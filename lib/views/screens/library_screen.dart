import 'package:flutter/material.dart';
import 'package:library_system/data/borrower.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  //! create instance variables here
  final borrower = Borrower('S001', 'Anna Lee', 'CCS', 5, 3, 1.5);

  //! create text editing controllers here
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController numBooksController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController penaltyController = TextEditingController();

  //! dispose controllers
  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    collegeController.dispose();
    numBooksController.dispose();
    daysController.dispose();
    penaltyController.dispose();
    super.dispose();
  }

  //! function when the add button is pressed
  void addBorrower(BuildContext context) {
    if (idController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        collegeController.text.isNotEmpty &&
        numBooksController.text.isNotEmpty &&
        daysController.text.isNotEmpty &&
        penaltyController.text.isNotEmpty) {
      setState(() {
        borrower.borrowerID = idController.text;
        borrower.borrowerName = nameController.text;
        borrower.college = collegeController.text;
        borrower.numBooksBorrowed = int.tryParse(numBooksController.text) ?? 0;
        borrower.days = int.tryParse(daysController.text) ?? 0;
        borrower.penalty = double.tryParse(penaltyController.text) ?? 0.0;
      });
      //! clear text fields after adding
      idController.clear();
      nameController.clear();
      collegeController.clear();
      numBooksController.clear();
      daysController.clear();
      penaltyController.clear();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Library System'), centerTitle: true),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(borrower.displayBorrwers()),
                TextField(
                  controller: idController,
                  decoration: InputDecoration(labelText: 'Enter ID Number'),
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Enter Name'),
                ),
                TextField(
                  controller: collegeController,
                  decoration: InputDecoration(labelText: 'Enter College'),
                ),
                TextField(
                  controller: numBooksController,
                  decoration: InputDecoration(labelText: 'Number of Books'),
                ),
                TextField(
                  controller: daysController,
                  decoration: InputDecoration(labelText: 'Days'),
                ),
                TextField(
                  controller: penaltyController,
                  decoration: InputDecoration(labelText: 'Penalty'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => addBorrower(context),
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
