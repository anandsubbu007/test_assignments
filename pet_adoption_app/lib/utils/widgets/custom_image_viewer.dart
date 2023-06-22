import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomImageViewer extends StatefulWidget {
  final String imageUrl;
  final String heroId;

  const CustomImageViewer({
    super.key,
    required this.imageUrl,
    required this.heroId,
  });

  @override
  State<CustomImageViewer> createState() => _CustomImageViewerState();
}

class _CustomImageViewerState extends State<CustomImageViewer> {
  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;
  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_doubleTapDetails == null) return;
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onDoubleTapDown: _handleDoubleTapDown,
            onDoubleTap: _handleDoubleTap,
            child: InteractiveViewer(
              transformationController: _transformationController,
              child: Container(
                color: Colors.black87,
                child: Center(
                  child: Hero(
                    tag: widget.heroId,
                    child: PhotoView(
                      imageProvider: NetworkImage(widget.imageUrl),
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      maxScale: PhotoViewComputedScale.covered * 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: IconButton.filled(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back)),
          )
        ],
      ),
    );
  }
}
