class BulkVariationInput {
  bool? bulkVariationForm;
  dynamic columns;
  dynamic rows;

  BulkVariationInput({
    this.bulkVariationForm,
    this.columns,
    this.rows,
  });

  factory BulkVariationInput.fromJson(Map<String, dynamic> json) => BulkVariationInput(
        bulkVariationForm: json["bulk_variation_form"],
        columns: json["columns"],
        rows: json["rows"],
      );

  Map<String, dynamic> toJson() => {
        "bulk_variation_form": bulkVariationForm,
        "columns": columns,
        "rows": rows,
      };
}

