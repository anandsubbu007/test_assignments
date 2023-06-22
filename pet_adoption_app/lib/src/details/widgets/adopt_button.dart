import 'package:flutter/material.dart';
import 'package:pet_adoption_app/provider/adoption.dart';
import 'package:pet_adoption_app/src/details/bloc/details_bloc.dart';
import 'package:pet_adoption_app/utils/theme/theme.dart';

class AdoptButton extends StatelessWidget {
  const AdoptButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailsBloc>();
    bool isAdopted = Provider.of<AdoptionProvider>(context).isAdopted(bloc.id);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  key: const Key("adopt"),
                  onPressed:
                      isAdopted ? null : () => bloc.onClickAdoptMe(context),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(!isAdopted
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor)),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(isAdopted ? "Already Adopted" : 'Adopt Me',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isAdopted ? null : Colors.white)),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
