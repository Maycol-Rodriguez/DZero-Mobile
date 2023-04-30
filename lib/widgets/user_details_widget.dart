import 'package:flutter/material.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle titleLarge = Theme.of(context).textTheme.titleLarge!;
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Miguel\nPerez',
            
            style: titleLarge,
          ),
          const CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
        ],
      ),
    );
  }
}
