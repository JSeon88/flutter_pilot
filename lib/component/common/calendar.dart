import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  // 날짜 선택 시 실행할 함수
  final OnDaySelected onDaySelected;
  // 선택된 날짜
  final DateTime selectedDate;
  final DateTime focusedDay;

  const Calendar({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
    required this.focusedDay,
  });

  @override
  Widget build(BuildContext context) {

    return TableCalendar(
      locale: 'ko-KR',
      daysOfWeekHeight: 30,
      onDaySelected: onDaySelected,
      onPageChanged: (focusedDay) {
        focusedDay = focusedDay;
      },
      selectedDayPredicate: (DateTime day){
        return isSameDay(selectedDate, day);
      },
      onHeaderLongPressed: (_) => print('hello'),
      firstDay: DateTime.now().subtract(const Duration(days: 365*3)),
      lastDay: DateTime.now(),
      focusedDay: focusedDay,
      // 달력 최상단 스타일
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        isTodayHighlighted: false,
        defaultDecoration: BoxDecoration(   // 기본 날짜 스타일
          borderRadius: BorderRadius.circular(6.0),
          // color: Colors.grey[200],
        ),
        weekendDecoration: BoxDecoration(   // 주말 날짜 스타일
          borderRadius: BorderRadius.circular(6.0),
          // color: Colors.grey[200],
        ),
        selectedDecoration: BoxDecoration(    // 선택된 날짜 스타일
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
              color: Color(0xFF0DB2B2),
              width: 1.0
          ),
        ),
        defaultTextStyle: TextStyle(    // 기본 글꼴
            fontWeight: FontWeight.w600,
            color: Colors.grey[600]
        ),
        weekendTextStyle: TextStyle(    // 주말 글꼴
            fontWeight: FontWeight.w600,
            color: Colors.red[600]
        ),
        selectedTextStyle: const TextStyle(   // 선택된 날짜 글꼴
          fontWeight: FontWeight.w600,
          color: Color(0xFF0DB2B2),
        ),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (BuildContext context, DateTime day) {
          final sunString = DateFormat.E("ko-KR").format(day);
          return Center(
            child: ExcludeSemantics(
              child: Text(
                sunString,
                style: _isSun(day)
                    ? TextStyle(
                    color: Colors.red[600]
                )
                    : TextStyle(
                    color: Colors.grey[600]
                ),
              ),
            ),
          );
        },
        defaultBuilder: (BuildContext context, DateTime day, DateTime focusedDay) {
            return Center(
              child: ExcludeSemantics(
                child: Text(
                  day.day.toString(),
                  style: _isSun(day)
                      ? TextStyle(
                          color: Colors.red[600]
                        )
                      : TextStyle(
                          color: Colors.grey[600]
                        ),
                ),
              ),
            );
        },
      ),
    );
  }

}

bool _isSun(
    DateTime day, {
      List<int> weekendDays = const [DateTime.sunday],
    }) {
  return weekendDays.contains(day.weekday);
}



