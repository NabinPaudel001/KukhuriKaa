import 'package:flutter/material.dart';

class ChickenManagementPage extends StatefulWidget {
  const ChickenManagementPage({super.key});

  @override
  State<ChickenManagementPage> createState() => _ChickenManagementPageState();
}

class _ChickenManagementPageState extends State<ChickenManagementPage> {
  int chickenAdded = 0;
  double chickenRate = 200.0;
  double averageRate = 200.0;
  List<Map<String, dynamic>> feedList = [];
  String selectedFood = 'Maize';
  double foodRate = 10.0;
  double foodUnits = 0.0;
  double totalFoodCost = 0.0;
  int deadChickens = 0;
  double totalCost = 0.0;
  double sellRate = 250.0;
  int chickensSold = 18;

  final List<String> foodItems = [
    'Maize',
    'Wheat',
    'Soybean Meal',
    'Rice Bran',
    'Fish Meal',
    'Peas',
    'Mustard Cake',
    'Peanut Meal',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Financial',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                  ),
            ),
            const SizedBox(height: 16),
            // No. of Chicken Added (Text Field)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No. of Chicken Added: ',
                    style: Theme.of(context).textTheme.bodyLarge),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            chickenAdded = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter...',
                          border: OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          chickenAdded++;
                        });
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Rate of Chicken
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rate of Chicken:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            chickenRate = double.tryParse(value) ?? 0.0;
                            averageRate = (chickenRate * chickenAdded) /
                                (chickenAdded > 0 ? chickenAdded : 1);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter rate',
                          border: OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          chickenRate++;
                        });
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Average Rate
            Text(
              'Average Rate: Rs.${averageRate.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: averageRate > 0 ? Colors.green : Colors.red,
                    fontSize: 18,
                  ),
            ),

            const SizedBox(height: 30),

            Text(
              'Feed Spent',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                  ),
            ),
            const SizedBox(height: 16),
            Text('Select Food:', style: Theme.of(context).textTheme.bodyLarge),
            DropdownButton<String>(
              value: selectedFood,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFood = newValue!;
                  foodRate = _getFoodRate(selectedFood);
                  totalFoodCost = foodRate * foodUnits;
                });
              },
              items: foodItems.map<DropdownMenuItem<String>>((String food) {
                return DropdownMenuItem<String>(
                  value: food,
                  child: Text(food),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Units Purchased (kg):',
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            foodUnits = double.tryParse(value) ?? 0.0;
                            totalFoodCost = foodRate * foodUnits;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter units in kg',
                          border: OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rate per kg:',
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            foodRate = double.tryParse(value) ?? 0.0;
                            totalFoodCost = foodRate * foodUnits;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter rate per kg',
                          border: OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Total Food Cost: Rs.${totalFoodCost.toStringAsFixed(2)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.green, fontSize: 18),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dead Chickens:',
                    style: Theme.of(context).textTheme.bodyLarge),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            deadChickens = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter...',
                          border: OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          deadChickens++;
                        });
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No. of Chicken Sold:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            chickensSold = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter...',
                          border: OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          chickensSold++;
                        });
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              'Total Cost: Rs.${(totalFoodCost + (chickenRate * chickenAdded)).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
            ),

            const SizedBox(height: 16),

            Text(
              'Sell Rate: Rs.${sellRate.toStringAsFixed(2)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 22, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            Text(
              'Profit and Loss: Rs.${(sellRate * chickensSold - (totalFoodCost + (chickenRate * chickenAdded))).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: (sellRate * chickensSold -
                                (totalFoodCost +
                                    (chickenRate * chickenAdded))) >
                            0
                        ? Colors.green
                        : Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  double _getFoodRate(String food) {
    switch (food) {
      case 'Maize':
        return 10.0;
      case 'Wheat':
        return 12.0;
      case 'Soybean Meal':
        return 15.0;
      case 'Rice Bran':
        return 8.0;
      case 'Fish Meal':
        return 20.0;
      case 'Peas':
        return 9.0;
      case 'Mustard Cake':
        return 11.0;
      case 'Peanut Meal':
        return 14.0;
      default:
        return 10.0;
    }
  }
}
