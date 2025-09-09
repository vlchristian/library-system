class Borrower {
  String borrowerID;
  String borrowerName;
  String college;
  int numBooksBorrowed;
  int days;
  double penalty;

  Borrower(
    this.borrowerID,
    this.borrowerName,
    this.college,
    this.numBooksBorrowed,
    this.days,
    this.penalty,
  );

  double calculatePenalty() {
    return numBooksBorrowed * days * penalty;
  }

  String displayBorrwers() {
    return 'Borrower ID: $borrowerID\nBorrower Name: $borrowerName\nCollege: $college\nBooks Borrowed: $numBooksBorrowed\nDays: $days\nPenalty: $penalty\nPenalty Fine: ${calculatePenalty()}';
  }
}
