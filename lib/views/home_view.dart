import 'package:flutter/material.dart';
import 'package:healjai/constants/color.dart';
import 'package:healjai/constants/routes.dart';
import 'package:healjai/services/auth/auth_backend_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80), // Set the desired size
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.only(top: 20, left: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'HealJai',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                  color: primaryPurple,
                ),
              ),
            ),
          ),
          actions: [
            InkWell(
        onTap: () {
          // Add your chat icon onPressed logic here
          Navigator.of(context).pushNamed(
            healTalkRoute,
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16),
          child: Image.asset(
            'assets/icons/chat.png', // Replace with the path to your custom image
            width: 30,
            height: 30,
          ),
        ),
      ),
          ],
        ),
      ),
      body: Column(
        children: [
         
          Expanded(
            child: ListView.builder(
                itemCount: 3, // Number of posts
                itemBuilder: (context, index) {
                  // Custom picture and text for each post
                  String imageUrl = '';
                  String name = '';
                  String post = '';
                  String caption = '';
          
                  if (index == 0) {
                    imageUrl =
                        'https://th.bing.com/th/id/R.58f60f6b81ae6d054b6b4910a9771fbf?rik=%2fKjN%2fqPR7wXaUw&pid=ImgRaw&r=0';
                    name = 'Dr.Wararattana Nara';
                    post = 'assets/images/quote1.jpg';
                    caption =
                        ' Can mental health issues be healed? While there is no cure for mental illnesses, help is available to help you lead a more productive life that you will enjoy more.';
                  } else if (index == 1) {
                    // Customize for post 3
                    imageUrl =
                        'https://s3.amazonaws.com/freestock-prod/450/freestock_49658134.jpg';
                    name = 'Dr. Pornpimon Kusonbhun';
                    post = 'assets/images/quote2.jpg';
                    caption = ' Taking care of your mental health is a journey worth investing in. 🌈 #SelfCareMatters.  Practicing self-care is not selfish; it is necessary! Set aside time for activities that bring you joy, relaxation, and rejuvenation. Remember, you can not pour from an empty cup.';
                  } else if (index == 2) {
                    imageUrl =
                        'https://img.freepik.com/free-photo/smiling-touching-arms-crossed-room-hospital_1134-799.jpg?t=st=1686406430~exp=1686407030~hmac=db7d79cf1f47e3bd475b2d2cffb875388078e256cf52a176894dce8acc079b30';
                    name = 'Dr. Sommai Guysa-ard';
                    post = 'assets/images/quote3.jpg';
                    caption =
                        ' Mental health is not a destination it is a lifelong journey of growth and resilience. 🌱💪 #EmbraceTheProcess';
                  }
          
                  return Column(
                    children: [
                      Divider( // Line between each ListView item
                    height: 4,
                    color: Colors.grey,
                  ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 16, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 53,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins'),
                                        ),
                                        // Add any additional text or widgets here
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 376,
                                child: Container(
                                  // width: MediaQuery.of(context).size.width, // Set the width to fit the screen
                                  // height: 376,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        post,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: SizedBox(
                                  height: 24,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/dot.png',
                                      width: 50, 
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'Poppins'),
                                          children: [
                                            TextSpan(
                                              text: name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: caption,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  );
                }),
          ),
        ],
      ),

      // Replace with your desired body content
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 42,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            // navigates to paymentRoute screen and removes previous routes
            paymentRoute,
          );
        },
        child: Image.asset(
          'assets/icons/noti.png', // Replace with the path to your custom image
          width: 42,
          height: 42,
        ),
      ),
      label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_rounded,
              size: 42,
              color: Color.fromARGB(255, 194, 194, 194),
            ),
            label: '',
          ),
        ],
        selectedItemColor: primaryPurple,
        onTap: (index) {
          if (index == 0) {
            // Handle home icon pressed
          } else if (index == 1) {
            Navigator.of(context).pushNamed(
              // navigates to paymentRoute screen and removes previous routes
              paymentRoute,
            );
          } else if (index == 2) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              // navigates to loginRoute screen and removes previous routes
              loginRoute,
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
//       body: Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.home),
//           onPressed: () {
//             // Add your home icon onPressed logic here
//           },
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pushNamed(
//               // navigates to paymentRoute screen and removes previous routes
//               paymentRoute,
//             );
//           },
//           child: const Icon(Icons.notifications),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pushNamedAndRemoveUntil(
//               // navigates to loginRoute screen and removes previous routes
//               loginRoute,
//               (route) => false,
//             );
//           },
//           child: const Text('Logout'),
//         ),
//       ],
//     ),
//   ],
// ),

//     );
//   }
// }
