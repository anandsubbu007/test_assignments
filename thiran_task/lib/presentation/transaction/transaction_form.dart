// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thiran_task/domain/model/transaction_model.dart';
import 'package:thiran_task/presentation/utilities/validation_utils.dart';
import 'package:thiran_task/presentation/widgets/filled_button.dart';

import '../utilities/app_function.dart';
import '../widgets/app_dropdown_item.dart';
import '../widgets/app_textfield.dart';
import '../../application/bloc/transaction/transaction_bloc.dart';

class NewTransactionPg extends StatefulWidget {
  const NewTransactionPg({Key? key}) : super(key: key);

  @override
  State<NewTransactionPg> createState() => _NewTransactionPgState();
}

class _NewTransactionPgState extends State<NewTransactionPg> {
  TextEditingController mDescController = TextEditingController();

  TextEditingController mDateTimeController = TextEditingController();
  String transactionStatus = "";

  @override
  void initState() {
    context.read<TransactionBloc>().add(OnFormLoadEvent());
    mDateTimeController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode mode = AutovalidateMode.disabled;
  Widget submit() => FilledAppButton(
        label: "Submit",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<TransactionBloc>().add(OnSaveEvent(
                transaction: TransactionM(
                    transactionDatetime: mDateTimeController.text,
                    transactionDesc: mDescController.text,
                    transactionStatus: transactionStatus)));
          } else {
            setState(() {
              mode = AutovalidateMode.always;
            });
          }
        },
      );
  Widget get fieldDesc => AppTextField(
      controller: mDescController,
      prefixIcon: const Icon(Icons.description_outlined),
      validator: (arg) {
        return ValidationUtils.validate(arg, "Description", context);
      },
      hint: "Description");

  Widget get fieldStatus => AppDropDownItem(
        "Transaction Status",
        onChange: (String value) {
          transactionStatus = value;
        },
        dropDownItems: const ["Success", "Pending", "Error"],
      );
  Widget get fieldTime => AppTextField(
        controller: mDateTimeController,
        prefixIcon: const Icon(Icons.date_range),
        hint: "DateTime",
        readOnly: true,
        validator: (arg) {
          return ValidationUtils.validate(arg, "DateTime", context);
        },
        onTap: () => getDate(DateTime.now()),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              const Text("Transaction", style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: Colors.grey[200],
        body: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is NewTransForm) {
              mDescController.clear();
              return SingleChildScrollView(
                  child: Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        autovalidateMode: mode,
                        key: _formKey,
                        child: Column(
                          children: [
                            fieldDesc,
                            fieldStatus,
                            fieldTime,
                            const SizedBox(height: 50),
                            submit(),
                            const SizedBox(height: 20),
                          ],
                        ))),
              ));
            } else if (state is TransactionError) {
              return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error.message!,
                        style: Theme.of(context).textTheme.displayLarge),
                  ]);
            } else if (state is TransactionSaved) {
              return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 70),
                            const Icon(Icons.done_all_rounded,
                                color: Colors.green, size: 40),
                            const Text("Transaction saved successful!"),
                            const SizedBox(height: 50),
                            FilledAppButton(
                              label: "Add New",
                              onPressed: () {
                                context
                                    .read<TransactionBloc>()
                                    .add(OnFormLoadEvent());
                              },
                            ),
                            const SizedBox(height: 30),
                            FilledAppButton(
                              label: "Transactions",
                              onPressed: () => Navigator.pop(context),
                            )
                          ])));
            } else {
              return AppFunctions.loadingWidget();
            }
          },
        ));
  }

  Future<void> getDate(DateTime date) async {
    final ddt = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2019),
        lastDate: DateTime.now().add(const Duration(days: 30)));
    if (ddt != null) {
      mDateTimeController.text = DateFormat('dd-MM-yyyy').format(ddt);
    }
  }
}
