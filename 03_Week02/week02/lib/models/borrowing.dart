class Borrowing {
  final String id;
  final String userId;
  final String bookId;
  final DateTime borrowDate;
  DateTime? returnDate;
  
  Borrowing({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.borrowDate,
    this.returnDate,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'bookId': bookId,
      'borrowDate': borrowDate.toIso8601String(),
      'returnDate': returnDate?.toIso8601String(),
    };
  }
  
  factory Borrowing.fromMap(Map<String, dynamic> map) {
    return Borrowing(
      id: map['id'],
      userId: map['userId'],
      bookId: map['bookId'],
      borrowDate: DateTime.parse(map['borrowDate']),
      returnDate: map['returnDate'] != null ? DateTime.parse(map['returnDate']) : null,
    );
  }
}