import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      home: HomeScreen(),
    );
  }
}

class Expense {
  String category;
  double value;

  Expense(this.category, this.value);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [];

  void _addExpense(String category, double value) {
    setState(() {
      expenses.add(Expense(category, value));
    });
  }

  double _getTotalExpense() {
    double totalExpense = 0.0;
    for (var expense in expenses) {
      totalExpense += expense.value;
    }
    return totalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text('Budget Tracker'),
          centerTitle: true,
          backgroundColor: Colors.orange[900],
          elevation: 0.0,

      ),
        body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Center(
    child: CircleAvatar(
    radius: 40.0,
    backgroundImage: AssetImage('assets/profile.png'),
     child: Text('Profile Pic'),
    ),
    ),
    Divider(
    color: Colors.grey[800],
    height: 60.0,
    ),
    Text(
    'NAME',
    style: TextStyle(
    color: Colors.grey[700],
    letterSpacing: 2.0,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),

    ),
    SizedBox(height: 10.0),
    Text(
    'Sahil Zodge',
    style: TextStyle(
    color: Colors.grey[900],
    fontWeight: FontWeight.bold,
    fontSize: 28.0,
    letterSpacing: 2.0,
    ),
    ),
    SizedBox(height: 30.0),
    Text(
    'Total Expense',
    style: TextStyle(
    color: Colors.grey[700],
    letterSpacing: 2.0,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    ),
      SizedBox(height: 20),
      Text(
          ' \$${_getTotalExpense().toStringAsFixed(2)}',
        style: TextStyle(
          color: Colors.grey[900],
          letterSpacing: 2.0,
          fontWeight: FontWeight.bold,
          fontSize: 28.0,

        ),),

      SizedBox(height: 30.0),
    Text(
    'For Category-wise expenses',
    style: TextStyle(
    color: Colors.grey[700],
    letterSpacing: 2.0,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExpenseScreen(
                expenses: expenses,
                addExpense: _addExpense,
              ),
            ),
          );
        },
        child: Text('Click here'),
      ),



    ],
    ),
    ),
    );
  }
}

class ExpenseScreen extends StatefulWidget {
  final List<Expense> expenses;
  final Function(String, double) addExpense;

  ExpenseScreen({required this.expenses, required this.addExpense});

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  String newCategory = '';
  double newExpense = 0.0;

  void _showAddExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    newCategory = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Category Name'),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  setState(() {
                    newExpense = double.tryParse(value) ?? 0.0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Expense Value'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newCategory.isNotEmpty && newExpense > 0) {
                  widget.addExpense(newCategory, newExpense);
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Category-wise Expenses'),
      centerTitle: true,
      backgroundColor: Colors.orange[900],),
      body: ListView.builder(
        itemCount: widget.expenses.length,
        itemBuilder: (context, index) {
          final expense = widget.expenses[index];
          return ListTile(
            title: Text(expense.category),
            subtitle: Text('Expense: \$${expense.value.toStringAsFixed(2)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddExpenseDialog(context);
        },
        child: Icon(Icons.add),
      ),

    );
  }
}
