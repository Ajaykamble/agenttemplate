import 'package:agenttemplate/agenttemplate.dart';
import 'package:agenttemplate/models/catalogue_response_model.dart';
import 'package:agenttemplate/models/file_object_model.dart';
import 'package:agenttemplate/models/file_upload_response.dart';
import 'package:agenttemplate/provider/agent_template_provider.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:agenttemplate/utils/media_helper.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HeaderForm extends StatefulWidget {
  final Component headerComponent;
  final Color backgroundColor;
  final Map<String, dynamic> predefinedAttributes;
  final String? fileObject;
  final Future<FileUploadResponse> Function(XFile file)? onFileUpload;
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
        Text("HEADER ATTRIBUTES", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
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
              children: [
                Text(attribute.title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(attribute.placeholder, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: attribute.textController,
              decoration: InputDecoration(hintText: "Enter Text"),
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
            if (widget.predefinedAttributes.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text("OR", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                valueListenable: attribute.selectedVariable,
                builder: (context, _, child) {
                  return DropdownButtonFormField(
                    items: widget.predefinedAttributes.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (value) {
                      attribute.textController.text = "";
                      attribute.selectedVariable.value = value;
                      attribute.selectedVariableValue.value = widget.predefinedAttributes[value];
                    },
                    initialValue: attribute.selectedVariable.value,
                    decoration: InputDecoration(hintText: "Select Variable"),
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
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: widget.headerComponent.attributes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

class _HeaderMediaForm extends StatefulWidget {
  final Component headerComponent;
  final String? fileObject;
  final Future<FileUploadResponse> Function(XFile file)? onFileUpload;
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
      final fileData = response.fileData?.firstOrNull;
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
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.insert_drive_file_outlined, color: Colors.grey.shade600, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(widget.headerComponent.headerFileNameController.text, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Upload File button
                      ElevatedButton(onPressed: onUploadClick, child: const Text("Upload File")),
                    ],
                  ),
                ),

                // File name display
                const SizedBox(width: 8),
                // Fetch button
                ElevatedButton(onPressed: setDefaultFileObject, child: const Text("Fetch")),
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
              decoration: InputDecoration(hintText: MediaHelper.mediaUrlHint(_mediaType)),
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
          hintText: "Enter Latitude",
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
          hintText: "Enter Longitude",
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
          hintText: "Enter Name",
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
          hintText: "Enter Address",
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
      children: [
        SizedBox(width: 100, child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
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
    agentTemplateProvider.getCatalogue();
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Thumbnail Product", style: Theme.of(context).textTheme.bodyMedium),
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
                return DropdownButtonFormField<ProductDetailsDatum>(
                  initialValue: selectedValue,
                  decoration: const InputDecoration(hintText: 'Select'),
                  items: (agentTemplateProvider.catalogueResponse?.productDetails?.data ?? [])
                      .map((product) => DropdownMenuItem<ProductDetailsDatum>(value: product, child: Text(product.name ?? product.id ?? '')))
                      .toList(),
                  onChanged: (value) {
                    widget.headerComponent.selectedProduct.value = value;
                  },
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
