import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/provider/agent_template_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class FlowForm extends StatefulWidget {
  final Component component;
  const FlowForm({super.key, required this.component});

  @override
  State<FlowForm> createState() => _FlowFormState();
}

class _FlowFormState extends State<FlowForm> {
  late AgentTemplateProvider agentTemplateProvider;
  TemplateButton? flowButton;
  @override
  void initState() {
    super.initState();
    agentTemplateProvider = Provider.of<AgentTemplateProvider>(context, listen: false);
    flowButton = widget.component.buttons?.firstWhereOrNull((element) => element.type == "FLOW");
    if (flowButton != null) {
      agentTemplateProvider.getFlowRawInfo(flowButton!.flowId!);
    }
  }

  @override
  void didUpdateWidget(FlowForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    flowButton = widget.component.buttons?.firstWhereOrNull((element) => element.type == "FLOW");
    if (flowButton != null && flowButton?.flowId != oldWidget.component.buttons?.firstWhereOrNull((element) => element.type == "FLOW")?.flowId) {
      agentTemplateProvider.getFlowRawInfo(flowButton!.flowId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (flowButton == null) {
      return SizedBox.shrink();
    }
    return Selector<AgentTemplateProvider, Tuple2<ApiStatus, FlowRawInfoResponse?>>(
      selector: (_, provider) => Tuple2(provider.flowRawInfoStatus, provider.flowRawInfoResponse),
      builder: (context, value, child) {
        switch (agentTemplateProvider.flowRawInfoStatus) {
          case ApiStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case ApiStatus.success:
            TemplateButton? flowButton = widget.component.buttons?.firstWhereOrNull((element) => element.type == "FLOW");

            if (flowButton?.flowRawAttributes.isNotEmpty ?? false) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Text("WhatsAppTestTemplateModule.initValues", style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 10),
                  ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 5),
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(flowButton?.flowRawAttributes[index].header ?? "", style: Theme.of(context).textTheme.bodyMedium),
                          TextFormField(
                            controller: flowButton?.flowRawAttributes[index].textController,
                            decoration: InputDecoration(hintText: "Enter value"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            //
                          ),
                        ],
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: flowButton?.flowRawAttributes.length ?? 0,
                  ),
                ],
              );
            }
            return SizedBox();

          case ApiStatus.error:
            return const Center(child: Text("Error loading flow raw info"));
        }
      },
    );
  }
}
