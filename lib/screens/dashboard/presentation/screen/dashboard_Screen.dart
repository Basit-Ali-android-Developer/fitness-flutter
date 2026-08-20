import 'package:flutter/material.dart'
    '';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
//
// class DashboardScreen extends StatelessWidget {
//    DashboardScreen({super.key});
//
//   final List<Widget> _pages =  [
//     HomeTab(),
//     ProjectTab(),
//     TaskTab(),
//     TimerTab(),
//     ProfileTab(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DashboardCubit(),
//       child: BlocBuilder<DashboardCubit, int>(
//         builder: (context, selectedIndex) {
//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             // IndexedStack preserves page states across tab switching
//             body: IndexedStack(
//               index: selectedIndex,
//               children: _pages,
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               currentIndex: selectedIndex,
//               onTap: (index) {
//                 context.read<DashboardCubit>().selectTab(index);
//               },
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: Colors.white,
//               elevation: 8,
//               selectedItemColor: AppColors.primary,
//               unselectedItemColor: Colors.grey,
//               selectedFontSize: 13,
//               unselectedFontSize: 12,
//               selectedLabelStyle: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//               showUnselectedLabels: true,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     'assets/icons/home_icon.svg',
//                     width: 24,
//                     height: 24,
//                     colorFilter: ColorFilter.mode(
//                       selectedIndex == 0 ? AppColors.primary : Colors.grey,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                   label: "Home",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     'assets/icons/project_icon.svg',
//                     width: 24,
//                     height: 24,
//                     colorFilter: ColorFilter.mode(
//                       selectedIndex == 1 ? AppColors.primary : Colors.grey,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                   label: "Project",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     'assets/icons/task_icon.svg',
//                     width: 24,
//                     height: 24,
//                     colorFilter: ColorFilter.mode(
//                       selectedIndex == 2 ? AppColors.primary : Colors.grey,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                   label: "Task",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     'assets/icons/timer_icon.svg',
//                     width: 24,
//                     height: 24,
//                     colorFilter: ColorFilter.mode(
//                       selectedIndex == 3 ? AppColors.primary : Colors.grey,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                   label: "Timer",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     'assets/icons/profile_icon.svg',
//                     width: 24,
//                     height: 24,
//                     colorFilter: ColorFilter.mode(
//                       selectedIndex == 4 ? AppColors.primary : Colors.grey,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                   label: "Profile",
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }