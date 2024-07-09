sealed class FieldValue<T> {
  final T value;
  const FieldValue(this.value);
}

class StringFieldValue extends FieldValue<String> {
  const StringFieldValue(super.value);

  factory StringFieldValue.create(String value) {
    return StringFieldValue(value);
  }
}

class DoubleFieldValue extends FieldValue<double> {
  const DoubleFieldValue(super.value);

  factory DoubleFieldValue.create(double value) {
    return DoubleFieldValue(value);
  }
}
