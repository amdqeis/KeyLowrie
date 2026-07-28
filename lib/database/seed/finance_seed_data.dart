class FinancialCategorySeed {
  const FinancialCategorySeed({
    required this.id,
    required this.name,
    required this.type,
    required this.iconKey,
  });

  final String id;
  final String name;
  final String type;
  final String iconKey;
}

const defaultFinancialCategorySeeds = <FinancialCategorySeed>[
  FinancialCategorySeed(
    id: 'expense-food-drink',
    name: 'Makanan dan Minuman',
    type: 'expense',
    iconKey: 'restaurant',
  ),
  FinancialCategorySeed(
    id: 'expense-transport',
    name: 'Transportasi',
    type: 'expense',
    iconKey: 'directions_car',
  ),
  FinancialCategorySeed(
    id: 'expense-shopping',
    name: 'Belanja',
    type: 'expense',
    iconKey: 'shopping_bag',
  ),
  FinancialCategorySeed(
    id: 'expense-bills',
    name: 'Tagihan',
    type: 'expense',
    iconKey: 'receipt_long',
  ),
  FinancialCategorySeed(
    id: 'expense-subscription',
    name: 'Langganan',
    type: 'expense',
    iconKey: 'subscriptions',
  ),
  FinancialCategorySeed(
    id: 'expense-health',
    name: 'Kesehatan',
    type: 'expense',
    iconKey: 'medical_services',
  ),
  FinancialCategorySeed(
    id: 'expense-education',
    name: 'Pendidikan',
    type: 'expense',
    iconKey: 'school',
  ),
  FinancialCategorySeed(
    id: 'expense-entertainment',
    name: 'Hiburan',
    type: 'expense',
    iconKey: 'movie',
  ),
  FinancialCategorySeed(
    id: 'expense-housing',
    name: 'Tempat Tinggal',
    type: 'expense',
    iconKey: 'home',
  ),
  FinancialCategorySeed(
    id: 'expense-household',
    name: 'Kebutuhan Rumah',
    type: 'expense',
    iconKey: 'cleaning_services',
  ),
  FinancialCategorySeed(
    id: 'expense-installment',
    name: 'Cicilan',
    type: 'expense',
    iconKey: 'payments',
  ),
  FinancialCategorySeed(
    id: 'expense-donation',
    name: 'Donasi',
    type: 'expense',
    iconKey: 'volunteer_activism',
  ),
  FinancialCategorySeed(
    id: 'expense-other',
    name: 'Lainnya',
    type: 'expense',
    iconKey: 'category',
  ),
  FinancialCategorySeed(
    id: 'income-salary',
    name: 'Gaji',
    type: 'income',
    iconKey: 'account_balance_wallet',
  ),
  FinancialCategorySeed(
    id: 'income-freelance',
    name: 'Freelance',
    type: 'income',
    iconKey: 'work',
  ),
  FinancialCategorySeed(
    id: 'income-bonus',
    name: 'Bonus',
    type: 'income',
    iconKey: 'redeem',
  ),
  FinancialCategorySeed(
    id: 'income-business',
    name: 'Bisnis',
    type: 'income',
    iconKey: 'business_center',
  ),
  FinancialCategorySeed(
    id: 'income-sale',
    name: 'Penjualan',
    type: 'income',
    iconKey: 'sell',
  ),
  FinancialCategorySeed(
    id: 'income-investment',
    name: 'Investasi',
    type: 'income',
    iconKey: 'trending_up',
  ),
  FinancialCategorySeed(
    id: 'income-gift',
    name: 'Hadiah',
    type: 'income',
    iconKey: 'card_giftcard',
  ),
  FinancialCategorySeed(
    id: 'income-reimbursement',
    name: 'Penggantian Biaya (Reimbursement)',
    type: 'income',
    iconKey: 'assignment_return',
  ),
  FinancialCategorySeed(
    id: 'income-refund',
    name: 'Refund',
    type: 'income',
    iconKey: 'undo',
  ),
  FinancialCategorySeed(
    id: 'income-other',
    name: 'Lainnya',
    type: 'income',
    iconKey: 'category',
  ),
];
