import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class UserExpense extends StatefulWidget {
  const UserExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<UserExpense> createState() {
    return _UserExpense();
  }
}

class _UserExpense extends State<UserExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;

  void _datepicker() async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);
    final datepicker = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now);

    setState(() {
      _selectedDate = datepicker;
    });
  }

  void _submitExpense(){
    final enteredAmount = double.tryParse(_amountcontroller.text);
    var validamount = enteredAmount == null || enteredAmount<= 0 ; 
    if(_titlecontroller.text.trim().isEmpty || validamount || _selectedDate == null){
        showDialog(context: context, builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter a valid title, amount, date'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
             child: const Text('back'),),
          ],
        ),);
        return;
    }

    widget.onAddExpense(Expense(name: _titlecontroller.text, 
    amount: enteredAmount,
     date: _selectedDate!,
    category: _selectedCategory),);

    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    final keyboardspace =   MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: 
    (ctx,constraints){
      final width = constraints.maxWidth;

       return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardspace+16),
          child: Column(
            children: [
              if(width>=600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                                        controller: _titlecontroller,
                                        maxLength: 50,
                                        decoration: const InputDecoration(
                      label: Text('Title'),
                                        )),
                    ),
                  const SizedBox(width: 24,),
                  Expanded(
                    child: TextField(
                      controller: _amountcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(label: Text('Amount')),
                    ),
                  ),
                  ],
                )
              else
              TextField(
                  controller: _titlecontroller,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  )),
              const SizedBox(
                height: 8,
              ),
              if(width>=600)
                Row(
                  children: [
                    DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'No Date Selected'
                            : formatter.format(_selectedDate!),
                      ),
                      IconButton(
                          onPressed: _datepicker,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  )),
                  ],
                )  
              else
                Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(label: Text('Amount')),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'No Date Selected'
                            : formatter.format(_selectedDate!),
                      ),
                      IconButton(
                          onPressed: _datepicker,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              if(width>=600)
                Row(
                  children: [
                    const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpense,//(){
                    //   print(_titlecontroller.text);
                    //   print(_amountcontroller.text);
                    //   print(_selectedCategory.name);
                    //   print(formatter.format(_selectedDate!));
                    // },                       //_submitExpense,
                    child: const Text('submit'),
                  ),
                  ],
                )
              else
                Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpense,//(){
                    //   print(_titlecontroller.text);
                    //   print(_amountcontroller.text);
                    //   print(_selectedCategory.name);
                    //   print(formatter.format(_selectedDate!));
                    // },                       //_submitExpense,
                    child: const Text('submit'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    });
   
  }
}
