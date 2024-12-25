import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_apis/logic/cubit/profile_cubit.dart';
import 'package:tasky_apis/presentation/widgets/aerror_widget.dart';
import 'package:tasky_apis/presentation/widgets/profile_element.dart';
import 'package:tasky_apis/presentation/widgets/secondary_appbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecodaryAppBar(
        title: "Profile",
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  ProfileElement(
                    title: "name".toUpperCase(),
                    data: state.profileResponse!.displayName!,
                  ),
                  const SizedBox(height: 10),
                  ProfileElement(
                    title: "email".toUpperCase(),
                    data: state.profileResponse!.username!,
                  ),
                  const SizedBox(height: 10),
                  ProfileElement(
                    title: "Level".toUpperCase(),
                    data: state.profileResponse!.level!,
                  ),
                  const SizedBox(height: 10),
                  ProfileElement(
                    title: "years of experience".toUpperCase(),
                    data: state.profileResponse!.experienceYears.toString(),
                  ),
                  const SizedBox(height: 10),
                  ProfileElement(
                    title: "location".toUpperCase(),
                    data: state.profileResponse!.address!,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          } else if (state is ProfileFail) {
            return const AErrorWidget();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
