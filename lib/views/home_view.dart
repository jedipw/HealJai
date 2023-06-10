import 'package:flutter/material.dart';
import 'package:healjai/constants/color.dart';
import 'package:healjai/constants/routes.dart';
import 'package:healjai/services/auth/auth_backend_service.dart';

class HomeView extends StatelessWidget {
  
  const HomeView({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          
          IconButton(
            icon: const Icon(
              Icons.chat_bubble,
              color: primaryPurple,
            ),
            onPressed: () {
              // Add your chat icon onPressed logic here
              Navigator.of(context).pushNamed(
                healTalkRoute,
              );
            },
          ),
        ],
      ),
    ),
     body: ListView.builder(
  itemCount: 5, // Number of posts
  itemBuilder: (context, index) {
  // Custom picture and text for each post
  String imageUrl = '';
    String name = '';
    String post = '';
    String caption = '';

    if (index == 0) {
      imageUrl = 'https://mypsychiatrist.com/wp-content/uploads/2022/02/successful-psychologist-talking-to-her-patient-SBI-324310484-scaled.jpg';
      name = 'Dr.Wararattana Nara';
      post = 'https://hips.hearstapps.com/hmg-prod/images/mental-health-quotes-noam-shpancer-1651243006.jpg?resize=980:*';
      caption = 'This is the caption for post 1.';
    } else if (index == 1) {
      imageUrl = 'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg?crop=0.66698xw:1xh;center,top&resize=1200:*';
      name = 'Dr. Jane Smith';
      caption = 'This is the caption for post 2.';
    } else if (index == 2) {
      // Customize for post 3
      imageUrl = 'https://www.phukethospital.com/wp-content/uploads/2023/03/1678158096874.jpg';
      name = 'Dr. Jane Smith';
      caption = 'This is the caption for post 2.';
    } else if (index == 3) {
      // Customize for post 4
    } else if (index == 4) {
      // Customize for post 5
    }
  
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                      image: NetworkImage(
                        imageUrl
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'
                      ),
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
            child: Expanded(
              child: Container(
                // width: MediaQuery.of(context).size.width, // Set the width to fit the screen
                // height: 376,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(padding: const EdgeInsets.symmetric(
              horizontal: 16, 
              vertical: 8,
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'Poppins'
                        ),
                        children: [
                          TextSpan(
                            text: 'Dr. Wararattana Nara',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: ' Can mental health issue be healed? While ther is no cure for mental illness, help is available to help you lead a more productive life that you will enjoy more.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),

              ],),
            ),
          )
        ],
      )
    );
  }
),


       // Replace with your desired body content
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 42,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined, size: 42,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, size: 42,),
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
          } else if (index == 2){
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

