import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gambling_game/app/features/menu/widgets/custom_button.dart';
import 'package:gambling_game/app/features/practice/providers/image_puzzle_provider.dart';
import 'package:image_picker/image_picker.dart';

class ImagePuzzleScreen extends ConsumerStatefulWidget {
  const ImagePuzzleScreen({super.key});

  @override
  ImagePuzzleScreenState createState() => ImagePuzzleScreenState();
}

class ImagePuzzleScreenState extends ConsumerState<ImagePuzzleScreen> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imagePuzzleProvider.notifier).disorderNumbers();
      _loadImage();
    });
  }

  Future<void> _loadImage() async {
    final image = await _loadAssetImage('assets/images/dog.jpg');
    setState(() {
      _image = image;
    });
  }

  Future<ui.Image> _loadAssetImage(String asset) async {
    final data = await DefaultAssetBundle.of(context).load(asset);
    final list = Uint8List.view(data.buffer);
    final codec = await ui.instantiateImageCodec(list);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      setState(() {
        _image = frame.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final puzzleState = ref.watch(imagePuzzleProvider);
    final provider = ref.read(imagePuzzleProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.green.shade50,
          ], // Light pastel gradient
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomButton(
              icon: Icons.image,
              width: double.infinity,
              label: 'Choose own image',
              onPressed: () async {
                await _pickImage();
                provider.disorderNumbers();
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Spacer(),
              CustomButton(
                icon: Icons.grid_on,
                width: 120,
                label: '3x3',
                onPressed: () {
                  provider.setGridSize(3);
                },
              ),
              const SizedBox(width: 8),
              CustomButton(
                icon: Icons.grid_on,
                label: '4x4',
                width: 120,
                onPressed: () {
                  provider.setGridSize(4);
                },
              ),
              const SizedBox(width: 8),
              CustomButton(
                icon: Icons.grid_on,
                label: '5x5',
                width: 120,
                onPressed: () {
                  provider.setGridSize(5);
                },
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue.shade800,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: _image == null
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: puzzleState.gridSize,
                      ),
                      itemCount: puzzleState.numbers.length,
                      itemBuilder: (context, index) {
                        int number = puzzleState.numbers[index];
                        if (number == 0 && !provider.isOrdered()) {
                          return Container(
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.blue.shade800,
                                width: 2,
                              ),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              int emptyIndex = puzzleState.numbers.indexOf(0);
                              if (provider.isAdjacent(index, emptyIndex)) {
                                provider.moveNumber(index);
                              }
                            },
                            child: ClipRect(
                              child: CustomPaint(
                                painter: ImagePainter(
                                  image: _image!,
                                  gridSize: puzzleState.gridSize,
                                  index: provider.isOrdered() && number == 0
                                    ? puzzleState.numbers.length - 1
                                    : number - 1,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
            ),
          ),
          const SizedBox(height: 40),
          if (provider.isOrdered())
            CustomButton(
              icon: Icons.refresh,
              label: 'Shuffle',
              onPressed: () {
                provider.disorderNumbers();
              },
            ),
        ],
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;
  final int gridSize;
  final int index;

  ImagePainter({
    required this.image,
    required this.gridSize,
    required this.index,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final tileSize = image.width / gridSize;
    final srcRect = Rect.fromLTWH(
      (index % gridSize) * tileSize,
      (index ~/ gridSize) * tileSize,
      tileSize,
      tileSize,
    );
    final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(image, srcRect, dstRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint when the image changes
  }
}
