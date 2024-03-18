
import 'package:flutter/material.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/theme/my_App_Theme.dart';
import '../bloc/get_student_appointments_bloc/get_student_appointments_bloc.dart';
import '../bloc/get_teacher_appointments_bloc/get_teacher_appointments_bloc.dart';


class SearchBarStudentAppointmentsWidget extends StatefulWidget {
  const SearchBarStudentAppointmentsWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarStudentAppointmentsWidget> createState() => _SearchBarStudentAppointmentsWidgetState();
}

class _SearchBarStudentAppointmentsWidgetState extends State<SearchBarStudentAppointmentsWidget> {
  final TextEditingController _searchController = TextEditingController();
  final Map<String, bool> _statusCheck = {
    'Accept': false,
    'Reject': false,
    'Pending': false,
  };
  bool _isSearching = false;

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) _searchController.clear();
    });
  }

  void _toggleStatus(String status) {
    setState(() {
      _statusCheck[status] = !_statusCheck[status]!;

      _addEventToBloc(context);
    });
  }

  void _addEventToBloc(BuildContext context) {
    final statuses = _statusCheck.keys
        .where((status) => _statusCheck[status]!)
        .map((status) => status == 'Accept' ? '3' : status == 'Reject' ? '2' : '1')
        .toList();
    BlocProvider.of<GetTeacherAppointmentsBloc>(context).list=statuses;
    BlocProvider.of<GetStudentAppointmentsBloc>(context)
        .add(GetStudentAppointments(status: statuses, numberPage:1));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffD9D9D9),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: _toggleSearch,
                icon: const Icon(Icons.search, color: Colors.black),
              ),
              Expanded(
                child: TextField(
                  cursorColor: Constants.secondaryColor,
                  style: MyAppTheme.myTheme.textTheme.bodySmall,
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.black),
                tooltip: 'Filter',
                onPressed: () {
                  showMenu(
                    context: context,
                    position: const RelativeRect.fromLTRB(100, 100, 30, 0),
                    items: _statusCheck.keys.map((status) {
                      return _buildPopupMenuItem(status, _toggleStatus);
                    }).toList(),
                  );
                },
              ),
              if (_isSearching)
                IconButton(
                  onPressed: _toggleSearch,
                  icon: const Icon(Icons.close, color: Colors.black),
                )
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, Function(String) onChanged) {
    return PopupMenuItem(
      child: SizedBox(
        width: 200,
        child: CheckboxListTileFormField(
          checkColor: Constants.primaryColor,
          activeColor: Constants.secondaryColor,
          title: Text(title),
          dense: _statusCheck[title]!,
          onChanged: (value) => onChanged(title),
          autovalidateMode: AutovalidateMode.always,
          contentPadding: const EdgeInsets.only(right: 20),
        ),
      ),
    );
  }
}
