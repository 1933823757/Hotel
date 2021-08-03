<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="js/jquery-1.11.1-min.js"></script>
    <link rel="stylesheet" href="//at.alicdn.com/t/font_2702840_12op6n1gh1yr.css">
    <link href="css/AnimationStyle/style.css" rel="stylesheet">
    <link href="css/AnimationStyle/style1.css" rel="stylesheet">
    <link href="css/login/login.css" rel="stylesheet">
    <title>用户登录</title>
    <style>
     
    </style>
    <script>
        
        $(function () {
          
            $("#code").click(function () {
                $("#code").attr("src","getCode.do?w="+new Date().getTime()+"");
            })
            $("#code2").click(function () {
                $("#code2").attr("src","getCode.do?w="+new Date().getTime()+"");
            })
            $("#signup").click(function () {
                $(".middle").toggleClass("middle-flip");
                $("#code2").attr("src","getCode.do?w="+new Date().getTime()+"");
            });
            $("#login").click(function () {
                $(".middle").toggleClass("middle-flip");
                $("#code").attr("src","getCode.do?w="+new Date().getTime()+"");
            });

            // 登录按钮提交事件
            $("#login-btn").click(function(){
                if(isInput($("#username"),$("#password"),$("#captcha"))){
                    // 提交函数写这
                    $.ajax({
                        url:"Verifylogin.do",
                        type:"get",
                        data:{
                            "username":$("#username").val().trim(),
                            "password":$("#password").val().trim(),
                            "captcha":$("#captcha").val().trim()
                        },
                        dataType:"json",
                        success:function (data) {
                        //    {"title":"","success":"true/false"
                            console.log(data.success)
                            if(data.success){

                            }else{

                                $(".prompt>span").html(""+data.title+"")
                                $(".prompt").removeClass("xianshi")
                            }
                        }
                    })
                    $(".prompt>span").html("")
                }
            })
            //账号输入框获得鼠标事件
            $("#username").focus(function(){
                clear($("#username"))
            })
            $("#password").focus(function(){
                clear($("#password"))
            })
            $("#captcha").focus(function(){
                clear($("#captcha"))
            })
		// 管理员按钮提交事件
		$("#administrators-btn").click(function(){
			if(isInput($("#username2"),$("#password2"),$("#captcha2"))){
					// 提交函数写这
				alert("asdfas")
				$(".prompt>span").html("")
			}
		})
		//管理员账号输入框获得鼠标事件
		$("#username2").focus(function(){
			clear($("#username2"))
		})
		$("#password2").focus(function(){
			clear($("#password2"))
		})
		$("#captcha2").focus(function(){
			clear($("#captcha2"))
		})
		
		
		
		
		// 清空输入框函数
		function clear(e){
			if($(".prompt>span").html()!=""){
				// 需要清空
				e.val("")
				  $(".prompt>span").html("")
				$(".prompt").addClass("xianshi")
			}
			e.val().trim()
		}
        })
		// 判断输入框是否为空函数
		function isInput(username,password,captcha){
			// 账号输入不能为空
			if(username.val().trim().length == 0 ||username.val()==""){
			  // 为空添加样式
						$(".prompt").removeClass("xianshi")
						$(".prompt>span").html("账号不能为空")
						return false
			}else if(password.val().trim().length ==0 || password.val() == ""){
						   $(".prompt").removeClass("xianshi")
						   $(".prompt>span").html("密码不能为空")
						  return false
			}else if(captcha.val().trim().length ==0 || captcha.val() == ""){
						   $(".prompt").removeClass("xianshi")
						   $(".prompt>span").html("验证码不能为空")
						 return false 
			}
			return true
		}
    </script>
</head>

<body>
    <div class="container">
        <div class="middle">
            <div class="login-wrapper front">
                <div class="header">Login</div>
                <div class="form-wrapper">
                    <input type="text" id="username" name="username" placeholder="账号" class="input-item">
                    <input type="password" id="password" name="password" placeholder="密码" class="input-item">
                    <input type="text" id="captcha" name="captcha" placeholder="验证码" class="input-item yanzheng">
                    <img src="getCode.do" alt="验证码" class="yanzheng-img" id="code">
                    <div class="prompt xianshi">
                        <i class="iconfont icon-jinggaozhuyi" style="color: red;" ></i>
                        <span style="color: red;"></span>
                    </div>
                    <div  id="ninth">
                        <button class="btn buttonBox" id="login-btn">登录</button>
                    </div>
                </div>
                <div class="msg">
                    没有帐户？
                    <a href="register.jsp">注册</a>
                    <p>切换管理员登录页?<a id="signup">点我切换</a></p>
                </div>
            </div>

            <div class="login-wrapper back">
                <div class="header">管理员登录</div>
                <div class="form-wrapper">
                    <input type="text" id="username2" name="username" placeholder="username" class="input-item">
                    <input type="password" id="password2" name="password" placeholder="password" class="input-item">
                    <input type="text" id="captcha2" name="captcha" placeholder="验证码" class="input-item yanzheng">
                    <img src="" alt="验证码" class="yanzheng-img" id="code2">
                    <div class="prompt xianshi">
                        <i class="iconfont icon-jinggaozhuyi" style="color: red;" ></i>
                        <span style="color: red;"></span>
                    </div>
                    <div id="ninth">
                        <button class="btn buttonBox" id="administrators-btn">登录</button>
                    </div>
                </div>
                <div class="msg">
                    切换普通用户？
                    <a id="login">点我切换</a>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
        <div class="circle-container">
            <div class="circle"></div>
        </div>
    </div>
</body>

</html>