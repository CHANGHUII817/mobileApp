import 'package:flutter/material.dart';

class TravelChecklistScreen extends StatefulWidget {
  @override
  _TravelChecklistScreenState createState() => _TravelChecklistScreenState();
}

class _TravelChecklistScreenState extends State<TravelChecklistScreen> {
  List<ChecklistItem> checklistItems = [
    ChecklistItem('여권'),
    ChecklistItem('현금'),
    ChecklistItem('지도'),
    ChecklistItem('의류'),
    ChecklistItem('신발'),
    ChecklistItem('카메라'),
    ChecklistItem('충전기'),
    ChecklistItem('약품'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '나의여행 준비물 체크리스트',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.purple,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.pink[100], // 연한 분홍 배경색 설정
        ),
        child: ListView.builder(
          itemCount: checklistItems.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: ListTile(
                title: Text(
                  checklistItems[index].name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: checklistItems[index].isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          checklistItems[index].isChecked = value!;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          checklistItems.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                for (var item in checklistItems) {
                  item.isChecked = false;
                }
              });
            },
            child: Icon(Icons.refresh),
            backgroundColor: Colors.red,
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              _showAddItemDialog(); // 항목 추가 다이얼로그 표시
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newItemName = ''; // 새로운 항목 이름을 저장할 변수

        return AlertDialog(
          title: Text('새로운 항목 추가'),
          content: TextField(
            onChanged: (value) {
              newItemName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  checklistItems.add(ChecklistItem(newItemName)); // 항목 리스트에 새로운 항목 추가
                });
                Navigator.of(context).pop();
              },
              child: Text('추가'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }
}

class ChecklistItem {
  String name;
  bool isChecked;

  ChecklistItem(this.name, {this.isChecked = false});
}

void main() {
  runApp(MaterialApp(
    home: TravelChecklistScreen(),
  ));
}