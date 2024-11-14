import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokuex/constants/appconstant_data.dart';

final selectedNotificationIndexProvider = StateProvider<int>((ref) => 0);

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .07,
            ),
            _myAppBar(context),
            SizedBox(
              height: size.height * .03,
            ),
            //tabs
            _tab(context),
            SizedBox(
              height: size.height * .02,
            ),
            //title n function
            Consumer(
              builder: (context, ref, child) {
                final index = ref.watch(selectedNotificationIndexProvider);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      index == 0
                          ? 'All Notifications'
                          : index == 1
                              ? 'Unread Notifications'
                              : 'Read Notifications',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: size.height * 0.016),
                    ),
                    index == 2
                        ? const SizedBox.shrink()
                        : Text(
                            'Mark all as read',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: myorange,
                                fontSize: size.height * 0.016),
                          ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _tab(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> _tabList = ['All', 'Unreade', 'Read '];
    return SizedBox(
      height: size.height * 0.055,
      width: size.width,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _tabList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Consumer(
                builder: (context, ref, child) {
                  final indexselected =
                      ref.watch(selectedNotificationIndexProvider);
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: size.width * .04),
                      child: GestureDetector(
                        onTap: () {
                          if (indexselected == index) {
                            return;
                          } else {
                            ref
                                .read(
                                    selectedNotificationIndexProvider.notifier)
                                .state = index;
                          }
                        },
                        child: Container(
                          height: size.height * .045,
                          width: size.width * .25,
                          decoration: BoxDecoration(
                            color: indexselected == index
                                ? Colors.black
                                : const Color.fromARGB(255, 50, 55, 61),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(3),
                          child: Center(
                            child: Text(
                              _tabList[index],
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  color: indexselected == index
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: size.height * 0.017),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
    );
  }

  Widget _myAppBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Notifications',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: size.height * 0.025),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
