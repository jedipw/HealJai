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
        preferredSize: const Size(double.infinity, 70), // Set the desired size
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
           bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4), // Set the thickness of the line
            child: Container(
              height: 1, // Set the height of the line
              color: const Color.fromARGB(255, 210, 210, 210), // Set the color of the line
            ),
          ),
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
                  fontSize: 24,
                  color: primaryPurple,
                ),
              ),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: IconButton(
                onPressed: () {
                  // Add your chat icon onPressed logic here
                  Navigator.of(context).pushNamed(
                    paymentRoute,
                  );
                },
                icon: Image.asset(
                  'assets/icons/chat.png', // Replace with the path to your custom image
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // const Divider(
          //   height: 2,
          //   color: Colors.grey,
          // ),
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
                    caption =
                        ' Taking care of your mental health is a journey worth investing in. 🌈 #SelfCareMatters.  Practicing self-care is not selfish; it is necessary! Set aside time for activities that bring you joy, relaxation, and rejuvenation. Remember, you can not pour from an empty cup.';
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
                      const Divider(
                        // Line between each ListView item
                        height: 1,
                        color: Colors.grey,
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 16, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      width: 40,
                                      height: 43,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          name,
                                          style: const TextStyle(
                                              fontSize: 14,
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
                                  padding: const EdgeInsets.fromLTRB(24, 8, 16, 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: Color.fromARGB(255, 210, 210, 210), width: 1),
              ),
            ),
            child: BottomNavigationBar(
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                    size: 32,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/noti.png', // Replace with the path to your custom image
                      width: 32,
                      height: 32,
                    ),
                  ),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.menu_rounded,
                      size: 32,
                      color: Color.fromARGB(255, 194, 194, 194),
                    ),
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
                  logout().then(
                      (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                            // navigates to homeRoute screen and removes previous routes
                            loginRoute,
                            (route) => false,
                          ));
                }
              },
            ),
          )
        ],
      ),

      // Replace with your desired body content
    );
  }
}
