class BMI {
  String? name;
  double? height;
  double? weight;
  double? bmi;
  DateTime? createdDate;

  BMI({
    this.name,
    this.height,
    this.weight,
    this.bmi,
    this.createdDate,
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'Name: ${name}, BMI: ${bmi}';
  }
}
