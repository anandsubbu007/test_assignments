import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_task/presentation/routers/routes.dart';
import 'package:thiran_task/presentation/utilities/app_function.dart';
import 'package:thiran_task/infrastructure/db/database_utils.dart';
import 'package:thiran_task/presentation/utilities/mailler.dart';
import '../../domain/model/transaction_model.dart';
import '../../application/bloc/transaction/transaction_bloc.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({Key? key}) : super(key: key);

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {


  Widget get errorReportButton =>
      !context.watch<TransactionBloc>().canIShowReport
          ? const SizedBox()
          : FloatingActionButton.extended(
              label: const Text("Report"),
              backgroundColor: Colors.redAccent,
              onPressed: () {
                AppMailier.triggerMail();
              });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transactions",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FutureBuilder<List<TransactionM>>(
          future: DBProvider.db.getAllTransaction(),
          builder: (context, snapshot) {
            final datas = snapshot.data ?? [];
            final isErrorReportAvailable = datas.any(
                (e) => e.transactionStatus.toString() == "Error".toString());
            return Row(
              children: [
                const SizedBox(width: 32),
                isErrorReportAvailable ? errorReportButton : const SizedBox(),
                const Spacer(),
                FloatingActionButton.extended(
                  heroTag: 'A',
                  label: const Text("New Transaction"),
                  backgroundColor: Colors.blueAccent,
                  onPressed: () async {
                    await Navigator.pushNamed(context, Routes.newTransaction);
                  },
                ),
              ],
            );
          }),
      body: FutureBuilder(
        future: context.watch<TransactionBloc>().getTransactions,
        builder: (context, snapshot) {
          final transactions = snapshot.data ?? [];
          return transactions.isEmpty
              ? const Center(
                  child: Text("No Data Found",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54)))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                          title: Text(transactions[index].transactionDesc!),
                          subtitle:
                              Text(transactions[index].transactionDatetime!),
                          trailing: Text(
                            transactions[index].transactionStatus!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: transactions[index]
                                  .transactionStatus!
                                  .getColorForStatus(),
                            ),
                          )),
                    );
                  },
                  separatorBuilder: (context, index) => Container(),
                  itemCount: transactions.length);
        },
      ),
    );
  }

  dynamic response;
}
