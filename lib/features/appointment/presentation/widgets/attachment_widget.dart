import 'dart:convert';
import 'dart:html';

import 'dart:io' as Io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/appointment/presentation/bloc/booking_appointment_bloc/booking_appointment_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:universal_html/html.dart' as html;
import '../../../teachers/presentation/widgets/becom_a_teacher_widgets/pdf_viewer.dart';
import '../../domain/entities/attachments_entity.dart';

enum TypeAttachment { pdf, image }

class AttachmentWidget extends StatefulWidget {
  int index;
  String path;

  AttachmentWidget({super.key, required this.index, required this.path});

  @override
  State<AttachmentWidget> createState() => _AttachmentWidgetState();
}

class _AttachmentWidgetState extends State<AttachmentWidget> {
  List<AttachmentsEntity> attachments = [];
  bool isImage = true;
  String imageAttachment = '';
  String url1 = '';

  String base64 = '';

  XFile? imageAttachmentFile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            await _askedToLead(context);
          },
          child: DottedBorder(
            strokeWidth: 2,
            color: Colors.black87,
            dashPattern: [6, 3, 2, 1],
            child: Container(
              width: 450.w,
              height: 350.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: widget.path == ''
                  ? InkWell(
                      onTap: () async {
                        await _askedToLead(context);
                      },
                      child: const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 50,
                      ))
                  : widget.path.contains('pdf')
                      ? SfPdfViewer.network(
                // base64Url.decode(widget.path
                //     .replaceFirst("data:image/pdf;base64,", ""))
                          widget.path,
                          enableDocumentLinkAnnotation: true,
                          enableTextSelection: true,
                        )
                      : SizedBox(
                          width: 400.w,
                          height: 300.h,
                          child: Image.network(
                           Io.File(BlocProvider.of<BookingAppointmentBloc>(context).attachments[widget.index].image.path).path,
    fit: BoxFit.fill,
                        ),
            ),
          ),
        ),
        ),
        Positioned(
            top: 5,
            right: 5,
            child: IconButton(
                onPressed: () async {
                  await _askedToLead(context);
                },
                icon: Icon(Icons.edit))),
      ],
    );
  }

  Future<void> _askedToLead(BuildContext context) async {
    switch (await showDialog<TypeAttachment>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            'Choose type of attachment',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff30C7EC),
            ),
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () async {
                await _pickPdfFromGalleryForFirstAttachment();

                Navigator.pop(context, TypeAttachment.pdf);
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'As PDF',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                _pickImageFromGalleryForFirstAttachment();

                Navigator.pop(context, TypeAttachment.image);
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'As jpg or png or...',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        );
      },
    )) {
      case TypeAttachment.pdf:
        break;
      case TypeAttachment.image:
        break;
      case null:
        break;
    }
  }

  Future<void> _pickPdfFromGalleryForFirstAttachment() async {
    if (kIsWeb) {
      final pdfFile = await pickPdfFromGallery();
      if (pdfFile != null) {
        final url = html.Url.createObjectUrl(pdfFile);
        final reader = html.FileReader();
        reader.readAsDataUrl(pdfFile);
        await reader.onLoad.first;
        base64 = reader.result as String;
        String b = base64.replaceFirst("application/pdf", "image/pdf");
        widget.path = b;
        // ignore: undefined_prefixed_name
        ui.platformViewRegistry.registerViewFactory(
          url,
          (int viewId) => IFrameElement()
            ..src = url
            ..style.border = 'none'
            ..height = '100%'
            ..width = '100%',
        );
        setState(() {
          isImage = false;
          url1 = url;
          BlocProvider.of<BookingAppointmentBloc>(context)
              .attachments[widget.index]
              .path = b;
        });
      }
    }
  }

  Future<void> _pickImageFromGalleryForFirstAttachment() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageAttachmentFile = pickedFile;
      BlocProvider.of<BookingAppointmentBloc>(context).attachments[widget.index].image=pickedFile;

      var imageCertificateBytes = await pickedFile.readAsBytes();
      String imageCertificate = base64Encode(imageCertificateBytes);

      setState(() {
        imageAttachment =
            "data:image/${pickedFile.name.split(".").last};base64,$imageCertificate";
        BlocProvider.of<BookingAppointmentBloc>(context)
            .attachments[widget.index]
            .path = imageAttachment;
        print('iiiiiiiiiiiiiiii');
        print(imageAttachment);
      });
    }
  }
}
