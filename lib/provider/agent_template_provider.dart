import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/models/catalogue_response_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum ApiStatus { loading, success, error }

class AgentTemplateProvider extends ChangeNotifier {
  //

  AgentTemplateProvider._();

  static final AgentTemplateProvider _instance = AgentTemplateProvider._();

  factory AgentTemplateProvider() {
    return _instance;
  }

  SendTemplateType? sendTemplateType;
  String? shortBaseUrl;

  Future<CatalogueResponseModel?> Function()? onGetCatalogue;
  Future<FlowRawInfoResponse?> Function(String flowId)? onGetFlowRawInfo;
  Future<DateTimeResponseModel?> Function()? onGetDateTime;
  ApiStatus _catalogueStatus = ApiStatus.loading;
  ApiStatus _flowRawInfoStatus = ApiStatus.loading;
  ApiStatus _dateTimeStatus = ApiStatus.loading;
  DateTimeResponseModel? _dateTimeResponse;
  ApiStatus get flowRawInfoStatus => _flowRawInfoStatus;

  bool _retryAttemptFailed = false;
  bool get retryAttemptFailed => _retryAttemptFailed;
  set retryAttemptFailed(bool value) {
    _retryAttemptFailed = value;
    retryAttemptController.text = "";
    notifyListeners();
  }

  TextEditingController retryAttemptController = TextEditingController();

  List<AdditionalDataModel> _additionalDataList = [];

  List<AdditionalDataModel> get additionalDataList => _additionalDataList;
  set additionalDataList(List<AdditionalDataModel> value) {
    _additionalDataList = value;
    notifyListeners();
  }

  void addAdditionalData() {
    additionalDataList.add(AdditionalDataModel());
    notifyListeners();
  }

  void removeAdditionalData(int index) {
    additionalDataList.removeAt(index);
    notifyListeners();
  }

  set flowRawInfoStatus(ApiStatus status) {
    _flowRawInfoStatus = status;
    notifyListeners();
  }

  ApiStatus get catalogueStatus => _catalogueStatus;

  set catalogueStatus(ApiStatus status) {
    _catalogueStatus = status;
    notifyListeners();
  }

  ApiStatus get dateTimeStatus => _dateTimeStatus;

  set dateTimeStatus(ApiStatus status) {
    _dateTimeStatus = status;
    notifyListeners();
  }

  DateTimeResponseModel? get dateTimeResponse => _dateTimeResponse;

  set dateTimeResponse(DateTimeResponseModel? response) {
    _dateTimeResponse = response;
    notifyListeners();
  }

  FlowRawInfoResponse? _flowRawInfoResponse;

  FlowRawInfoResponse? get flowRawInfoResponse => _flowRawInfoResponse;

  set flowRawInfoResponse(FlowRawInfoResponse? response) {
    _flowRawInfoResponse = response;
    notifyListeners();
  }

  CatalogueResponseModel? _catalogueResponse;

  CatalogueResponseModel? get catalogueResponse => _catalogueResponse;

  set catalogueResponse(CatalogueResponseModel? response) {
    _catalogueResponse = response;
    notifyListeners();
  }

  TemplateObj? _templateObj;

  TemplateObj? get templateObj => _templateObj;

  /// Other Params;

  set templateObj(TemplateObj? templateObj) {
    _templateObj = templateObj;
    resetPageData();
    notifyListeners();
  }

  void resetPageData() {
    _retryAttemptFailed = false;
    retryAttemptController.text = "";
    _additionalDataList = [];
  }

  /// Resets all provider data: API statuses, responses, template, and page data.
  void resetAllData() {
    _catalogueStatus = ApiStatus.loading;
    _flowRawInfoStatus = ApiStatus.loading;
    _dateTimeStatus = ApiStatus.loading;
    _dateTimeResponse = null;
    _flowRawInfoResponse = null;
    _catalogueResponse = null;
    _templateObj = null;
    resetPageData();
  }

  // Catalogue

  Future<void> getCatalogue() async {
    if (_catalogueResponse != null) return;
    try {
      catalogueStatus = ApiStatus.loading;
      catalogueResponse ??= await onGetCatalogue?.call();
      catalogueStatus = ApiStatus.success;
    } catch (e) {
      catalogueStatus = ApiStatus.error;
    }
  }

  void getFlowRawInfo(String flowId) async {
    try {
      flowRawInfoStatus = ApiStatus.loading;
      flowRawInfoResponse = await onGetFlowRawInfo?.call(flowId);

      if (flowRawInfoResponse != null) {
        //
        Component? buttonsComponent = templateObj?.components?.firstWhereOrNull((element) => element.type == 'BUTTONS');
        if (buttonsComponent != null) {
          //
          TemplateButton? flowButton = buttonsComponent.buttons?.firstWhereOrNull((element) => element.type == "FLOW");
          if (flowButton != null) {
            FlowRawScreen? screenData = flowRawInfoResponse?.rawInfo?.screens.firstWhereOrNull((element) => element.id == flowButton.navigateScreen);
            flowButton.flowRawScreenData = screenData;
            if (sendTemplateType == SendTemplateType.normal) {
              flowButton.flowRawAttributes = screenData?.getFlowScreenAttributes(sendTemplateType!) ?? [];
            } else {
              List<FlawRawScreenAttributes> list = [];
              for (FlowRawScreen screen in (flowRawInfoResponse?.rawInfo?.screens ?? [])) {
                list.addAll(screen.getFlowScreenAttributes(sendTemplateType!));
              }
              flowButton.flowRawAttributes = list;
            }
          }
        }
      }

      flowRawInfoStatus = ApiStatus.success;
    } catch (e) {
      flowRawInfoStatus = ApiStatus.error;
    }
  }

  void getDateTime() async {
    try {
      dateTimeStatus = ApiStatus.loading;
      dateTimeResponse = await onGetDateTime?.call();
      dateTimeStatus = ApiStatus.success;
    } catch (e) {
      dateTimeStatus = ApiStatus.error;
    }
  }

  //
}
