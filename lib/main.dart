import 'package:flutter/material.dart';
import 'dart:async';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  DeviceCalendarPlugin _deviceCalendarPlugin;
  List<Calendar> _calendars;
  Calendar _selectedCalendar;
  List<Event> _calendarEvents;

  MyHomePageState() {
    _deviceCalendarPlugin = DeviceCalendarPlugin();
  }
  int _userCalendar = 2; // id is 3
  String _userCalendarId = '3';

  @override
  initState() {
    super.initState();
    _retrieveCalendars();
    _retrieveCalendarEvents(_userCalendarId);
//    String _title = _calendars[_userCalendar].name;

//    print('Nr of Calendars: ${_calendars?.length}');
//    print('Calendar ${_calendars[1]}');
//    print('Selected calendar Id ${_calendars[_userCalendar].id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events:'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            tooltip: 'Today',
            onPressed: null,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
//          ConstrainedBox(
//            constraints: BoxConstraints(maxHeight: 150.0),
//            child: ListView.builder(
//              itemCount: _calendars?.length ?? 0,
//              itemBuilder: (BuildContext context, int index) {
//                return GestureDetector(
//                  onTap: () async {
//                    await _retrieveCalendarEvents(_calendars[index].id);
//                    setState(() {
//                      _selectedCalendar = _calendars[index];
//                    });
//                  },
//                  child: Padding(
//                    padding: const EdgeInsets.all(10.0),
//                    child: Row(
//                      children: <Widget>[
//                        Expanded(
//                          flex: 1,
//                          child: Text(
//                            _calendars[index].name,
//                            style: TextStyle(fontSize: 25.0),
//                          ),
//                        ),
//                        Icon(_calendars[index].isReadOnly
//                            ? Icons.lock
//                            : Icons.lock_open)
//                      ],
//                    ),
//                  ),
//                );
//              },
//            ),
//          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListView.builder(
                itemCount: _calendarEvents?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return EventItem(
                      _calendarEvents[index], _deviceCalendarPlugin, () async {
                    await _retrieveCalendarEvents(_userCalendarId);
                  });
                },
              ),
            ),
          ),
        ],
      ),
//      floatingActionButton: !(_selectedCalendar?.isReadOnly ?? true)
      floatingActionButton: !(false)
          ? FloatingActionButton(
              onPressed: () async {
                final now = DateTime.now();
                final eventToCreate = Event(_selectedCalendar.id);
                eventToCreate.title =
                    "Event created with Device Calendar Plugin";
                eventToCreate.start = now;
                eventToCreate.end = now.add(Duration(hours: 1));
                final createEventResult = await _deviceCalendarPlugin
                    .createOrUpdateEvent(eventToCreate);
                if (createEventResult.isSuccess &&
                    (createEventResult.data?.isNotEmpty ?? false)) {
                  _retrieveCalendarEvents(_selectedCalendar.id);
                }
              },
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }

  void _retrieveCalendars() async {
    try {
      var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data) {
        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
          return;
        }
      }

      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      setState(() {
        _calendars = calendarsResult?.data;
//        print('After _receiveCalandars ${_calendars[8].name}');
//        print('Nr of Calendars: ${_calendars.length}');
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future _retrieveCalendarEvents(String calendarId) async {
    try {
      final startDate = DateTime.now().add(Duration(days: -365));
//      final startDate = DateTime.now().add(Duration(days: -30));
      final endDate = DateTime.now().add(Duration(days: 3650)); // 10 years
      final retrieveEventsParams =
          RetrieveEventsParams(startDate: startDate, endDate: endDate);
      final eventsResult = await _deviceCalendarPlugin.retrieveEvents(
          calendarId, retrieveEventsParams);

      setState(() {
        _calendarEvents = eventsResult?.data;
        print(
            'Calandar Id: $calendarId, Event ${_calendarEvents[0]?.eventId}'); // each _calendarEvent is an calendar entry
      });
    } catch (e) {
      print(e);
    }
  }
}

class EventItem extends StatelessWidget {
  final Event _calendarEvent;
  final DeviceCalendarPlugin _deviceCalendarPlugin;
  final Function onDeleteSucceeded;
  final double _eventFieldNameWidth = 75.0;

  EventItem(
      this._calendarEvent, this._deviceCalendarPlugin, this.onDeleteSucceeded);

  // format date

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            leading: Text(
              '${_calendarEvent.start.day.toString()}/${_calendarEvent.start.month.toString()}/${_calendarEvent.start.year.toString()}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueAccent,
              ),
            ),
            title: Text(
              _calendarEvent.title ?? '',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
              ),
            ),
            subtitle: Text(_calendarEvent.description ?? ''),
            trailing: CircleAvatar(
              radius: 30,
              child: Text(_calendarEvent.allDay != null && _calendarEvent.allDay
                  ? 'All Day'
                  : '${_calendarEvent.start.hour.toString()}:${_calendarEvent.start.minute.toString()}'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _calendarEvent.location,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        final deleteResult =
                            await _deviceCalendarPlugin.deleteEvent(
                                _calendarEvent.calendarId,
                                _calendarEvent.eventId);
                        if (deleteResult.isSuccess && deleteResult.data) {
                          onDeleteSucceeded();
                        }
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        final deleteResult =
                            await _deviceCalendarPlugin.deleteEvent(
                                _calendarEvent.calendarId,
                                _calendarEvent.eventId);
                        if (deleteResult.isSuccess && deleteResult.data) {
                          onDeleteSucceeded();
                        }
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
