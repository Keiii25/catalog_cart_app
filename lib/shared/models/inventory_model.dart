class Inventory {
  int? branchId;
  dynamic batchId;
  double? stockQuantity;
  double? physicalStockQuantity;

  Inventory({
    this.branchId,
    this.batchId,
    this.stockQuantity,
    this.physicalStockQuantity,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        branchId: json["branch_id"],
        batchId: json["batch_id"],
        stockQuantity: json["stock_quantity"]?.toDouble(),
        physicalStockQuantity: json["physical_stock_quantity"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "branch_id": branchId,
        "batch_id": batchId,
        "stock_quantity": stockQuantity,
        "physical_stock_quantity": physicalStockQuantity,
      };
}
