import 'package:flutter/material.dart';

import '../widgets/boxDecorationWidget.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 100),
                    const Text(
                      'About us',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff666F80),
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                // Mission Statement
                Text(
                  'Mission Statement',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff323747),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'A Recovery Oriented Peer Group, to unify all peer groups.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff323747),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'The mission of Recovery “ready to go” is to serve persons in recovery from addiction, their loved ones and recovery community partners, by improving their access to best evidence-based practices, standards, support services, placement, education and advocacy.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'The Recovery “ready to go”, LLC Board of Directors are a Recovery Oriented Peer Group (ROPG) endeavor to share their experience, strength and hope to advocate a recovery lifestyle. If you, a family member, a co-worker or a friend are struggling with the effects of addiction, there is hope!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),

                SizedBox(height: 30),

                // Team Member: Tim Carpenter
                Text(
                  'Tim Carpenter',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff323747),
                  ),
                ),
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 40,
                  child: Image.asset("assets/tim_carpenter.png"),
                  // Replace with your local asset image path or NetworkImage if hosted
                ),
                SizedBox(height: 10),
                Text(
                  'Hearthstone Houses, LLC CEO\nMontani Semper Liberi\nRecovery “ready to go” LLC, Chairman & CEO',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff323747),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Tim knows personally the devastating effects alcoholism and substance use can have on people, families, and communities. Tim is a person in long term recovery who retired from a corporate position in 2002, then pulling from those transferable corporate skills to actively serve the Recovery community. In 2011 became a volunteer recovery family group facilitator.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'He opened Hearthstone Houses recovery residences in 2018, based on NARR (National Alliance for Recovery Residences), TROHN (Texas Recovery Oriented Housing Network), and is N STARR accredited. He also is recognized as a recovery housing collaborator and former Housing Committee co-chairperson for ROSC Houston Recovery Initiative.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),

                SizedBox(height: 30),

                // Team Member: Matthew W. Lee
                Text(
                  'Matthew W. Lee',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff323747),
                  ),
                ),
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 40,
                  child: Image.asset("assets/matthew_lee.png"),
                ),
                SizedBox(height: 10),
                Text(
                  'Hearthstone Houses, LLC\nOperations Manager\nRecovery “ready to go” LLC - Executive Program Manager & Board Member',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff323747),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Matthew’s professional background includes more than 15 years as a licensed funeral director and more than 5 years as president of a private equity real estate investment firm. He draws from his experiences helping individuals in crisis when assisting the residents of Hearthstone Houses.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Though Matthew is not in recovery, he, like 90% of Americans, has lived under the same roof with individuals who have struggled with alcohol and substance use and he holds in high regard the importance and potential of every human life.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),

                SizedBox(height: 30),

                // Team Member: Don Hall
                Text(
                  'Don Hall',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff323747),
                  ),
                ),
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 40,
                  child: Image.asset("assets/don_hall.png"),
                ),
                SizedBox(height: 10),
                Text(
                  'MBA, BS, LCDC, CPT\nCase Manager/Counselor\nRecovery “ready to go” LLC, Board Member',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff323747),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Don Hall is a person in long-term recovery, which to him means that he has not had a needle in his arm for recreational purposes for over thirty-five years. Since the initiation of his recovery, he became an LCDC in 1993 and has spent most of his career working with substance-using, homeless, indigent, criminal justice, and mental health individuals, as well as working for many years with opiate-abusing individuals seeking medication-assisted treatment.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'He has been employed at SEARCH Homeless Services for the last twenty-eight years, most recently in the position of Counselor/Case manager at a Housing-First site for chronic homeless. He also is employed part-time by Adult Rehabilitation Services, a medication-assisted treatment facility, where he has been the lead counselor for the last twenty-one+ years. He is now listed as the Site Manager at that facility.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'He is an adjunct professor in Human Services at Houston Community College and at Lonestar College- Houston North. He is currently the Housing Committee co-chairperson for the Houston Recovery Initiative. He is the Chairperson of the Opioid Task Force for the Houston Recovery Initiative. He is involved with the Houston-Harris County Office of Drug Control Policy and the Coalition of Behavioral Health. He completed his BS in Human Services and an MBA in Non-Profit Management in October 2021.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),

                SizedBox(height: 30),

                // Team Member: Samantha Hepford
                Text(
                  'Samantha Hepford',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff323747),
                  ),
                ),
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 40,
                  child: Image.asset("assets/samantha_hepford.png"),
                ),
                SizedBox(height: 10),
                Text(
                  'RSPS\nHearthstone Houses, LLC - Community Developement Manager\nRecovery “ready to go” LLC - Board Member',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff323747),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Samantha Hepford has been an integral member of the Hearthstone Houses team for 2 years, where she has dedicated herself to providing compassionate care and support to individuals and families impacted by substance use. In her role, Samantha has developed a deep understanding of the challenges faced by individuals in recovery and has consistently demonstrated a strong commitment to fostering positive, lasting change in their lives.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Her experience includes facilitating support groups, conducting one-on-one coaching sessions, and collaborating with community organizations to ensure holistic care for those she serves. Samantha’s work is grounded in empathy, active listening, and the belief in each person’s potential to achieve recovery and personal growth. She has witnessed first hand the profound impact that well-structured support systems and evidence-based approaches can have on individuals struggling with substance use.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Samantha has a background in corporate management and restructuring within the finance and health care sectors. For the past 20 years, she has been an entrepreneur, successfully leading companies on both national and international levels.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666F80),
                  ),
                ),

                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
