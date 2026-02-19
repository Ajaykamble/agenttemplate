import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/models/catalogue_response_model.dart';
import 'package:agenttemplate/models/file_object_model.dart';
import 'package:agenttemplate/provider/agent_template_provider.dart';
import 'package:agenttemplate/utils/media_helper.dart';
import 'package:agenttemplate/widget/forms/form_styles.dart';
import 'package:cross_file/cross_file.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HeaderForm extends StatefulWidget {
  final Component headerComponent;
  final Color backgroundColor;
  final Map<String, dynamic> predefinedAttributes;
  final String? fileObject;
  final Future<FileUploadResponse?> Function(XFile file)? onFileUpload;
  const HeaderForm({super.key, required this.headerComponent, required this.backgroundColor, required this.predefinedAttributes, this.fileObject, this.onFileUpload});

  @override
  State<HeaderForm> createState() => _HeaderFormState();
}

class _HeaderFormState extends State<HeaderForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.headerComponent.format == "TEXT" && widget.headerComponent.attributes.isEmpty) {
      return SizedBox.shrink();
    }

    if (widget.headerComponent.format == "PRODUCT") {
      return _HeaderProductForm(headerComponent: widget.headerComponent);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Header Attributes", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        //
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(10)),
          child: Builder(
            builder: (context) {
              //
              if (widget.headerComponent.format == "TEXT") {
                return _HeaderTextForm(headerComponent: widget.headerComponent, predefinedAttributes: widget.predefinedAttributes);
              }
              if (widget.headerComponent.format == "IMAGE" || widget.headerComponent.format == "VIDEO" || widget.headerComponent.format == "DOCUMENT") {
                return _HeaderMediaForm(headerComponent: widget.headerComponent, fileObject: widget.fileObject, onFileUpload: widget.onFileUpload);
              }

              if (widget.headerComponent.format == "LOCATION") {
                return _HeaderLocationForm(headerComponent: widget.headerComponent);
              }

              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

class _HeaderTextForm extends StatefulWidget {
  final Component headerComponent;
  final Map<String, dynamic> predefinedAttributes;
  const _HeaderTextForm({super.key, required this.headerComponent, required this.predefinedAttributes});

  @override
  State<_HeaderTextForm> createState() => _HeaderTextFormState();
}

class _HeaderTextFormState extends State<_HeaderTextForm> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        AttributeClass attribute = widget.headerComponent.attributes[index];
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 35,
                  child: Row(
                    children: [
                      Text(attribute.title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800)),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 35,
                        child: Text(attribute.placeholder, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 65,
                  child: TextFormField(
                    controller: attribute.textController,
                    decoration: FormStyles.buildInputDecoration(context, hintText: attribute.placeholder),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      attribute.selectedVariable.value = null;

                      if (value.isNotEmpty) {
                        attribute.selectedVariableValue.value = value;
                      } else {
                        attribute.selectedVariableValue.value = attribute.placeholder;
                      }
                    },
                  ),
                ),
              ],
            ),
            if (widget.predefinedAttributes.isNotEmpty) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(flex: 35, child: SizedBox.shrink()),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 65,
                    child: Column(
                      children: [
                        Text("OR", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        ValueListenableBuilder(
                          valueListenable: attribute.selectedVariable,
                          builder: (context, _, child) {
                            return DropdownButtonFormField2<String>(
                              items: widget.predefinedAttributes.keys.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
                              onChanged: (value) {
                                attribute.textController.text = "";
                                attribute.selectedVariable.value = value;
                                attribute.selectedVariableValue.value = widget.predefinedAttributes[value];
                              },
                              value: attribute.selectedVariable.value,
                              decoration: FormStyles.buildInputDecoration(context, hintText: "Select Variable"),
                              dropdownStyleData: FormStyles.buildDropdownStyleData(context),
                              menuItemStyleData: FormStyles.buildMenuItemStyleData(context),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: widget.headerComponent.attributes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

class _HeaderMediaForm extends StatefulWidget {
  final Component headerComponent;
  final String? fileObject;
  final Future<FileUploadResponse?> Function(XFile file)? onFileUpload;
  const _HeaderMediaForm({super.key, required this.headerComponent, this.fileObject, this.onFileUpload});

  @override
  State<_HeaderMediaForm> createState() => __HeaderMediaFormState();
}

class __HeaderMediaFormState extends State<_HeaderMediaForm> {
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    setDefaultFileObject();
  }

  void setDefaultFileObject() {
    FileObject? object = FileObjectHelper.parseFileObjects(widget.fileObject).firstOrNull;

    widget.headerComponent.setFileObject(object);
  }

  String get _mediaType => widget.headerComponent.format ?? 'FILE';

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> onUploadClick() async {
    final extensions = MediaHelper.allowedExtensions(_mediaType);

    final result = await FilePicker.platform.pickFiles(type: extensions.isNotEmpty ? FileType.custom : FileType.any, allowedExtensions: extensions.isNotEmpty ? extensions : null);

    if (result == null || result.files.isEmpty) return;

    final pickedFile = result.files.first;

    // Check file size limit
    if (pickedFile.size > MediaHelper.maxFileSizeInBytes(_mediaType)) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Template selected media type $_mediaType, it accepts upto ${MediaHelper.maxFileSize(_mediaType)}.';
      });
      return;
    }
    //

    // Clear error on valid file
    setState(() {
      _errorMessage = null;
    });

    // Call the onFileUpload callback if provided
    if (widget.onFileUpload != null && pickedFile.path != null) {
      final xFile = pickedFile.xFile;
      final response = await widget.onFileUpload!(xFile);
      final fileData = response?.fileData?.firstOrNull;
      if (fileData != null) {
        widget.headerComponent.setFileObject(FileObject(fileName: fileData.fileName, filePath: fileData.filePath, localPath: fileData.localPath, mediaId: fileData.mediaId?.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.headerComponent.selectedFileObject,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Upload File" label
            Text("Upload File", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blueGrey)),
            const SizedBox(height: 8),
            // File picker row: file name + Upload File button + Fetch button
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.insert_drive_file_outlined, color: Colors.grey.shade600, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.headerComponent.headerFileNameController.text.isEmpty ? "No file selected" : widget.headerComponent.headerFileNameController.text,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Upload File button
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: onUploadClick,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007BFF),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                            ),
                          ),
                          child: const Text("Upload File"),
                        ),
                      ),
                    ],
                  ),
                ),

                if ((widget.fileObject ?? "").isNotEmpty) ...[
                  const SizedBox(width: 10),
                  // Fetch button
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: setDefaultFileObject,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007BFF),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Fetch"),
                    ),
                  ),
                ],

                // File name display
              ],
            ),
            const SizedBox(height: 12),
            // "Or" separator
            Center(
              child: Text("Or", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            // URL input field
            TextFormField(
              controller: widget.headerComponent.headerFileUrlController, //TextEditingController(text: value?.filePath),
              decoration: FormStyles.buildInputDecoration(context, hintText: MediaHelper.mediaUrlHint(_mediaType)),
              onChanged: (value) {
                //
                widget.headerComponent.onManualSetFileUrl(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 6),
            // Note about media type and size limit
            Text(
              "Note : Template selected media type $_mediaType, it accepts upto ${MediaHelper.maxFileSize(_mediaType)}.",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
            ),
            if (_errorMessage != null) ...[const SizedBox(height: 6), Text(_errorMessage!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error))],
          ],
        );
      },
    );
  }
}

class _HeaderLocationForm extends StatefulWidget {
  final Component headerComponent;
  const _HeaderLocationForm({super.key, required this.headerComponent});

  @override
  State<_HeaderLocationForm> createState() => __HeaderLocationFormState();
}

class __HeaderLocationFormState extends State<_HeaderLocationForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField(
          label: "Latitude",
          controller: widget.headerComponent.latitudeController,
          hintText: "Latitude",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Latitude is required';
            }
            if (double.tryParse(value) == null) {
              return 'Enter a valid latitude';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        _buildField(
          label: "Longitude",
          controller: widget.headerComponent.longitudeController,
          hintText: "Longitude",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Longitude is required';
            }
            if (double.tryParse(value) == null) {
              return 'Enter a valid longitude';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        _buildField(
          label: "Name",
          controller: widget.headerComponent.locationNameController,
          hintText: "Name",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        _buildField(
          label: "Address",
          controller: widget.headerComponent.locationAddressController,
          hintText: "Address",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Address is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildField({required String label, required TextEditingController controller, required String hintText, String? Function(String?)? validator}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 35,
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800)),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 65,
          child: TextFormField(
            controller: controller,
            decoration: FormStyles.buildInputDecoration(context, hintText: hintText),
            validator: validator,
          ),
        ),
      ],
    );
  }
}

class _HeaderProductForm extends StatefulWidget {
  final Component headerComponent;
  const _HeaderProductForm({super.key, required this.headerComponent});

  @override
  State<_HeaderProductForm> createState() => __HeaderProductFormState();
}

class __HeaderProductFormState extends State<_HeaderProductForm> {
  late AgentTemplateProvider agentTemplateProvider;

  @override
  void initState() {
    super.initState();
    agentTemplateProvider = Provider.of<AgentTemplateProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await agentTemplateProvider.getCatalogue();
      widget.headerComponent.catalogueResponse = agentTemplateProvider.catalogueResponse;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Select Thumbnail Product ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF64748B)), // Light blue/grey
              ),
              TextSpan(
                text: "*",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Selector<AgentTemplateProvider, Tuple2<ApiStatus, int>>(
          selector: (_, agentTemplateProvider) => Tuple2(agentTemplateProvider.catalogueStatus, agentTemplateProvider.catalogueResponse?.productDetails?.data?.length ?? 0),
          builder: (context, value, child) {
            if (agentTemplateProvider.catalogueStatus == ApiStatus.loading) {
              return const CircularProgressIndicator();
            }
            if (agentTemplateProvider.catalogueStatus == ApiStatus.error) {
              return Text("Error loading catalogue", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red));
            }
            if (value.item2 == 0) {
              return Text("No products found", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red));
            }
            return ValueListenableBuilder<ProductDetailsDatum?>(
              valueListenable: widget.headerComponent.selectedProduct,
              builder: (context, selectedValue, child) {
                return DropdownButtonFormField2<ProductDetailsDatum>(
                  value: selectedValue,
                  decoration: FormStyles.buildInputDecoration(context, hintText: 'Select'),
                  items: (agentTemplateProvider.catalogueResponse?.productDetails?.data ?? [])
                      .map((product) => DropdownMenuItem<ProductDetailsDatum>(value: product, child: Text(product.name ?? product.id ?? '')))
                      .toList(),
                  onChanged: (value) {
                    widget.headerComponent.selectedProduct.value = value;
                  },
                  dropdownStyleData: FormStyles.buildDropdownStyleData(context),
                  menuItemStyleData: FormStyles.buildMenuItemStyleData(context),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a thumbnail product';
                    }
                    return null;
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
