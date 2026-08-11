abstract class TransactionSummaryState {

}

class TransactionSummaryInitial extends TransactionSummaryState {

}

class TransactionSummaryCalculated extends TransactionSummaryState {
  final double totalBalance;
  final double totalIncome;
  final double totalExpenses;

  TransactionSummaryCalculated({
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpenses,
  });
}