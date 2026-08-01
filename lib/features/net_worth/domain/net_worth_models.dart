class NetWorthInitializationModel {
  const NetWorthInitializationModel({
    required this.id,
    required this.initialAmount,
    required this.initializationDate,
    required this.currencyCode,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  static const singletonId = 'local_net_worth';

  final String id;
  final int initialAmount;
  final DateTime initializationDate;
  final String? notes;
  final String currencyCode;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class NetWorthAdjustmentModel {
  const NetWorthAdjustmentModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.adjustmentDate,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  final String id;
  final String name;
  final int amount;
  final DateTime adjustmentDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class NetWorthOverview {
  const NetWorthOverview({
    required this.initialization,
    required this.totalIncome,
    required this.totalExpense,
    required this.totalAdjustments,
    required this.currentNetWorth,
    required this.lastUpdatedAt,
  });

  final NetWorthInitializationModel initialization;
  final int totalIncome;
  final int totalExpense;
  final int totalAdjustments;
  final int currentNetWorth;
  final DateTime lastUpdatedAt;
}

class NetWorthDetail {
  const NetWorthDetail({required this.overview, required this.adjustments});

  final NetWorthOverview overview;
  final List<NetWorthAdjustmentModel> adjustments;
}
