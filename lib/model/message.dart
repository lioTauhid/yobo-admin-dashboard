class Message {
  String? question;
  String? answer;
  String? timestamp;

  Message({this.question, this.answer, this.timestamp});

  Message.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = question;
    data['answer'] = answer;
    data['timestamp'] = timestamp;
    return data;
  }
}
