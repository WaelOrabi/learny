
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/working_times_bloc.dart';
import 'time_field.dart';



class WorkingPeriods extends StatelessWidget {

   int indexPeriod;
   int indexDay;
   TimeOfDay? firstTime;
   TimeOfDay ?secondTime;

      WorkingPeriods({super.key,required this.indexPeriod,required this.indexDay, this.firstTime, this.secondTime});

   WorkingPeriods copyWith() {
     return WorkingPeriods(
       indexDay: indexDay,
       indexPeriod: indexPeriod,
       firstTime: firstTime,
       secondTime: secondTime,
     );
   }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          const Text(
            'From:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
           TimeField(firstTime:firstTime,first: true,indexDay: indexDay,indexPeriod: indexPeriod,),
          const SizedBox(
            width: 50,
          ),
          const Text(
            'To:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          TimeField(second: true,indexDay: indexDay,indexPeriod: indexPeriod,secondTime: secondTime,),
          IconButton(
              onPressed: () {
                  BlocProvider.of<WorkingTimesBloc>(context).add(DeletePeriodEvent(indexPeriod: indexPeriod, indexDay: indexDay));
            },
            icon: const Icon(
              Icons.delete,
              size: 15,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
