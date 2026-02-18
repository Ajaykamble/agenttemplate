import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/models/catalogue_response_model.dart';
import 'package:agenttemplate/models/flow_raw_info_response_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum ApiStatus { loading, success, error }

class AgentTemplateProvider extends ChangeNotifier {
  //

  Future<CatalogueResponseModel> Function()? onGetCatalogue;
  Future<FlowRawInfoResponse> Function(String flowId)? onGetFlowRawInfo;

  ApiStatus _catalogueStatus = ApiStatus.loading;
  ApiStatus _flowRawInfoStatus = ApiStatus.loading;

  ApiStatus get flowRawInfoStatus => _flowRawInfoStatus;

  set flowRawInfoStatus(ApiStatus status) {
    _flowRawInfoStatus = status;
    notifyListeners();
  }

  ApiStatus get catalogueStatus => _catalogueStatus;

  set catalogueStatus(ApiStatus status) {
    _catalogueStatus = status;
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

  set templateObj(TemplateObj? templateObj) {
    _templateObj = templateObj;
    notifyListeners();
  }

  void clearTemplate() {
    _templateObj = null;
  }

  // Catalogue

  void getCatalogue() async {
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
        Component? BUTTONS_COMPONENT = templateObj?.components.firstWhereOrNull((element) => element.type == 'BUTTONS');
        if (BUTTONS_COMPONENT != null) {
          //
          TemplateButton? flowButton = BUTTONS_COMPONENT.buttons?.firstWhereOrNull((element) => element.type == "FLOW");
          if (flowButton != null) {
            FlowRawScreen? screenData = flowRawInfoResponse?.rawInfo?.screens.firstWhereOrNull((element) => element.id == flowButton.navigateScreen);
            flowButton.flowRawScreenData = screenData;
          }
        }
      }

      flowRawInfoStatus = ApiStatus.success;
    } catch (e) {
      flowRawInfoStatus = ApiStatus.error;
    }
  }

  //
}
