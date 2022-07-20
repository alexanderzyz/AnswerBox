package com.example.Controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.example.Domain.Address;
import com.example.Service.AddressService;
import com.example.Service.Impl.AddressServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/address")
public class AddressController {
    @Autowired
    private AddressServiceImpl addressService;
    @PostMapping("/getAddress")
    public Result getAddress(HttpServletRequest req){
        try {
            Object userId = req.getSession().getAttribute("userId");
            List<Address> address = addressService.getAddress((Integer) userId);
            return new Result(Code.QUERYSUCCESS, address);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(Code.QUERYERROR,"","地址信息查询失败");
        }
    }
    @PostMapping("/addAddress")
    public Result addAddress(String address,HttpServletRequest req){
        try {
            JSONObject jsonObject = JSON.parseObject(address);
            Address address1 = new Address();
            address1.setUserId((Integer) req.getSession().getAttribute("userId"));
            address1.setReceiverName((String) jsonObject.get("receiverName"));
            address1.setAddress((String) jsonObject.get("address"));
            address1.setDetailAddress((String) jsonObject.get("detailAddress"));
            address1.setIdCode((String) jsonObject.get("idCode"));
            address1.setPhoneNumber((String) jsonObject.get("phoneNumber"));
            address1.setLandline((String) jsonObject.get("landLine"));
            address1.setDefaultAddress((Boolean) jsonObject.get("defaultAddress"));
            if (address1.isDefaultAddress()){
                addressService.updateDefault((Integer) req.getSession().getAttribute("userId"));
            }
            addressService.addAddress(address1);
            return new Result(Code.ADDSUCCESS,"");
        }catch (Exception e){
            e.printStackTrace();
            return new Result(Code.ADDERROR, "","添加地址出现错误");
        }

    }
}
