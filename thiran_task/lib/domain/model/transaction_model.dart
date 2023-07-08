class TransactionM {
  final int? transactionId;
  final String? transactionDesc;
  final String? transactionStatus;
  final String? transactionDatetime;

  TransactionM({
    this.transactionId,
    this.transactionDesc,
    this.transactionStatus,
    this.transactionDatetime,
  });

  TransactionM.fromJson(Map<String, dynamic> json)
      : transactionId = json['transaction_id'] as int?,
        transactionDesc = json['transaction_desc'] as String?,
        transactionStatus = json['transaction_status'] as String?,
        transactionDatetime = json['transaction_datetime'] as String?;

  Map<String, dynamic> toJson() => {
        'transaction_id': transactionId,
        'transaction_desc': transactionDesc,
        'transaction_status': transactionStatus,
        'transaction_datetime': transactionDatetime
      };
}
