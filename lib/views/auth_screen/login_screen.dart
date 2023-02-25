import 'package:emart_app/consts/consts.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.1,),
              applogoWidget(),
              const SizedBox(height: 10,),
              const Text("Log in to $appname",style: TextStyle(fontSize: 18,fontFamily: bold,color: whiteColor),),
              const SizedBox(height: 10,),
              Container(
                width: width - 70,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                child: Obx(
                  ()=> Column(
                    children: [
                      customTextField(hint: emailhint,title: email,obscure: false,controller: controller.emailController),
                      customTextField(hint: passwordhint,title: password,obscure: true,controller: controller.passwordController),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){},child:const Text(forgetPass))),
                        const SizedBox(height: 5,),
                        controller.isloading.value ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          ) : SizedBox(
                          width: width - 50,
                          child: ourButton(
                            title:login,
                            color: redColor,
                            textcolor: whiteColor,
                            onPress: ()async {
                              controller.isloading(true);

                              await controller.loginMethod(context: context).then((value){
                                if (value != null){
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(()=> const Home());
                                }else{
                                  controller.isloading(false);
                                }
                              });
                          }),
                          ),
                        const SizedBox(height: 5,),
                        const Text(createNewAccount,style: TextStyle(color: fontGrey),),
                        const SizedBox(height: 5,),
                        SizedBox(
                          width: width - 50,
                          child: ourButton(title:signup,color: lightGolden,textcolor: redColor,onPress: (){
                            Get.to(()=> const SignUpScreen());
                          }),
                          ),
                          const SizedBox(height: 10,),
                          const Text(loginwith,style: TextStyle(color: fontGrey),),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(socialIconList[index],width: 30,),
                              ),
                            )),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
  }
}