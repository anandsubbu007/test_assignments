import 'package:flutter/material.dart';
import 'package:pet_adoption_app/model/pet_model.dart';
import 'package:pet_adoption_app/provider/adoption.dart';
import 'package:pet_adoption_app/utils/theme/theme.dart';
import 'package:pet_adoption_app/utils/widgets/pet_image.dart';

/// Pet List Tile Widget
class PetWidget extends StatefulWidget {
  const PetWidget({
    Key? key,
    this.onTap,
    required this.pet,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final PetModel pet;

  @override
  State<PetWidget> createState() => _PetWidgetState();
}

class _PetWidgetState extends State<PetWidget> {
  late TextTheme textTheme;
  late bool isAdopted;
  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    isAdopted = Provider.of<AdoptionProvider>(context).isAdopted(widget.pet.id);
    final radius = BorderRadius.circular(24.0);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: radius),
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor, borderRadius: radius),
          child: Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                    tag: widget.pet.id,
                    child: PetImageWidget(imagePath: widget.pet.image)),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.pet.name, style: textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      '${widget.pet.age} Old',
                      style: textTheme.labelMedium,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Gender: ${widget.pet.sex}',
                      style: textTheme.labelMedium,
                    ),
                    const SizedBox(height: 18),
                  ],
                )
              ],
            ),

            /// If Adopted showing faded color
            Positioned.fill(
                child: InkWell(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .cardColor
                      .withOpacity(isAdopted ? .6 : 0),
                  borderRadius: radius,
                ),
              ),
            )),

            /// Rating
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(4.0),
                  ),
                ),
                child: Text(
                  widget.pet.rate.toString(),
                  style: textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),

            /// Already Adopted
            if (isAdopted)
              Positioned(
                right: 4,
                bottom: 2,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Text(
                    'Already Adopted',
                    style: textTheme.bodySmall!.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              )
          ]),
        ),
      ),
    );
  }
}
