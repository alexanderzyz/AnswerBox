SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phoneNumber` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phoneNumber`(`phoneNumber`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;




SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `receiverName` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `detailAddress` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `idCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phoneNumber` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `landLine` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `defaultAddress` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `addressuser_id`(`userid`) USING BTREE,
  CONSTRAINT `addressuser_id` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;



SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `goodsid` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cartuser_id`(`userid`) USING BTREE,
  INDEX `cartgoods_id`(`goodsid`) USING BTREE,
  CONSTRAINT `cartgoods_id` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cartuser_id` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `introduction` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;





SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `money` double(11, 2) NOT NULL,
  `userAddress` int(11) NULL DEFAULT NULL,
  `finish` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ordersuser_id`(`userid`) USING BTREE,
  INDEX `user_address`(`userAddress`) USING BTREE,
  CONSTRAINT `ordersuser_id` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_address` FOREIGN KEY (`userAddress`) REFERENCES `address` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;






SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `orders_detail`;
CREATE TABLE `orders_detail`  (
  `id` int(11) NOT NULL,
  `orderTime` datetime NOT NULL,
  `finishTime` datetime NULL DEFAULT NULL,
  `goodsid` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  INDEX `order_id`(`id`) USING BTREE,
  INDEX `goods_id`(`goodsid`) USING BTREE,
  CONSTRAINT `goods_id` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_id` FOREIGN KEY (`id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO goods(id,name,introduction,img,price) VALUES(1,'Sukin HandWash洗手液 250ml','消毒 呵护双手','images/hot_1.jpg',47.00);
INSERT INTO goods(id,name,introduction,img,price)  VALUES(2,'Sukin Conditioner护发素 250ml','天然蛋白滋养','images/hot_2.jpg',40.00);
INSERT INTO goods(id,name,introduction,img,price)  VALUES(3,'Sukin Shampoo洗发水 250ml','呵护头皮 补水保湿','images/hot_3.jpg',40.00);
INSERT INTO goods(id,name,introduction,img,price)  VALUES(4,'Sukin RoseHipOil玫瑰果油 25ml','美白淡斑 延缓衰老','images/hot_4.jpg',112.00);
INSERT INTO goods(id,name,introduction,img,price)  VALUES(5,'Sukin 极致修复滋养润唇膏 10ml','深层修复滋养 保护唇部','images/hot_5.jpg',35.00);
INSERT INTO goods(id,name,introduction,img,price)  VALUES(6,'Sukin FacialMoisturiser润肤霜 125ml','修复肌肤 滋养保湿','images/hot_6.jpg',45.00);
INSERT INTO goods(id,name,introduction,img,price) VALUES(7,'Sukin NightCream晚霜 120ml','天然保湿 锁水修复','images/hot_7.jpg',78.00);
INSERT INTO goods(id,name,introduction,img,price) VALUES(8,'Sukin EyeSerum眼霜 30ml','天然有机 抗氧化','images/hot_8.jpg',77.00);
INSERT INTO goods(id,name,introduction,img,price) VALUES(9,'Sukin DayCream日霜 120ml','补水保湿 滋润淡斑','images/hot_9.jpg',85.00);
INSERT INTO goods(id,name,introduction,img,price) VALUES(10,'紧致肌肤 清洁毛孔','Sukin Facial Masque 面膜 100ml','images/hot_10.jpg',65.00);
INSERT INTO goods(id,name,introduction,img,price) VALUES(11,'Sukin BodyLotion润肤乳液 250ml','天然有机 保湿补水','images/hot_11.jpg',53.00);
INSERT INTO goods(id,name,introduction,img,price) VALUES(12,'Sukin FacialScrab面部磨砂膏 125ml','去除角质 靓丽肌肤','images/hot_12.jpg',40.00);
INSERT INTO goods(id,name,introduction,img,price) VALUES(13,'Sukin FoamingCleanser洁面泡沫 125ml','深层清洁 平衡油脂','images/hot_13.jpg',40.00);
INSERT INTO goods(id,name,introduction,img,price) VALUES(14,'Sukin AvoeVeraGEL芦荟胶 125ml','淡化痘印 美白祛斑','images/hot_14.jpg',40.00);
INSERT INTO goods(id,name,introduction,img,price) VALUES(15,'Sukin MistToner保湿喷雾 125ml','保湿补水 舒缓修复','images/hot_15.jpg',40.00);
INSERT INTO goods(id,name,introduction,img,price) VALUES(16,'Sukin BodyWash沐浴露 500ml','舒缓、镇静肌肤','images/hot_16.jpg',203.00);