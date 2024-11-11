class Option {
  late String label;
  dynamic value;

  Option(Map<String, dynamic> data){
    this.label = data["label"];
    this.value = data["value"];
  }

  Map<String, dynamic> toJson(){
    return {
      'label': this.label,
      'value': this.value
    };
  }
}