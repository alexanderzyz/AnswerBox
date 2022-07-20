package com.example.Controller;

import com.example.Domain.User;
import com.example.Service.Impl.UserServiceImpl;
import com.wf.captcha.SpecCaptcha;
import com.wf.captcha.utils.CaptchaUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserServiceImpl userService;
    @PostMapping("/queryRegister")
    public Result queryRegister(String phoneNumber){
        System.out.println(phoneNumber);
        return new Result(Code.QUERYSUCCESS,userService.queryRegister(phoneNumber)?"true":"false","用户名重复了");
    }
    @PostMapping("/register")
    public Result register(String username,String password,String phoneNumber,String captcha,String email,HttpServletRequest httpServletRequest){
        if(captcha!=null && captcha.toLowerCase().equals(httpServletRequest.getSession().getAttribute("captcha"))){
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setPhoneNumber(phoneNumber);
            user.setEmail(email);
            userService.Register(user);
            CaptchaUtil.clear(httpServletRequest);
            return new Result(Code.ADDSUCCESS,user);
        }
        else {
            return new Result(Code.ADDERROR, "","验证码错误");
        }
    }
    @RequestMapping("/captcha")
    public void code(HttpServletRequest request, HttpServletResponse response) throws IOException {
        SpecCaptcha captcha=new SpecCaptcha();
        captcha.setLen(4);
        String text = captcha.text();
        request.getSession().setAttribute("captcha",text.toLowerCase());
        captcha.out(response.getOutputStream());
    }

    @PostMapping("/login")
    public Result login(String login,String password,String captcha,Boolean remember,HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse){
        if (captcha!=null && captcha.toLowerCase().equals(httpServletRequest.getSession().getAttribute("captcha"))){
            User login1 = userService.Login(login, password);
            if (login1 !=null){
                Cookie cookie;
                Cookie cookie1;
                System.out.println(remember);
                if (remember){
                    cookie = new Cookie("login", login);
                    cookie1 = new Cookie("password", password);
                    cookie.setMaxAge(60*60*24*7);
                    cookie1.setMaxAge(60*60*24*7);
                }
                else {
                    cookie = new Cookie("login", "");
                    cookie1 = new Cookie("password", "");
                    cookie.setMaxAge(0);
                    cookie1.setMaxAge(0);
                }
                httpServletResponse.addCookie(cookie);
                httpServletResponse.addCookie(cookie1);
                httpServletRequest.getSession().setAttribute("userId", login1.getId());
                return new Result(Code.QUERYSUCCESS,login1);
            }
            else {
                return new Result(Code.QUERYERROR,"","账号密码错误");
            }
        }
        else{
            return new Result(Code.QUERYERROR, "","验证码输入错误");
        }
    }

    @PostMapping("/queryLogin")
    public Result queryLogin(HttpServletRequest httpServletRequest){
        Cookie[] cookies = httpServletRequest.getCookies();
        String login=null;
        String password=null;
        if(cookies!=null){
            for (Cookie var:cookies){
                if (var.getName().equals("login")){
                    login=var.getValue();
                }
                else if (var.getName().equals("password")){
                    password=var.getValue();
                }
            }
        }
        User user1 = new User();
        user1.setPhoneNumber(login);
        user1.setPassword(password);
        if(login!=null&& password!=null){
            return new Result(Code.QUERYSUCCESS,user1);
        }
        else {
            return new Result(Code.QUERYERROR, "");
        }
    }
}
