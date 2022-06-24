from collections import OrderedDict
from scipy.spatial import distance as dist
import numpy as np
import argparse
import dlib
import cv2


def driving(queue):


    FACIAL_LANDMARKS_68_IDXS = OrderedDict(
        [
            ("mouth_1", (48, 60)),
            ("mouth_2", (60, 68)),
            ("right_eyebrow", (17, 22)),
            ("left_eyebrow", (22, 27)),
            ("right_eye", (36, 42)),
            ("left_eye", (42, 48)),
            ("nose", (27, 36)),
            ("jaw", (0, 17)),
        ]
    )

    (LSTART, LEND) = FACIAL_LANDMARKS_68_IDXS["left_eye"]
    (RSTART, REND) = FACIAL_LANDMARKS_68_IDXS["right_eye"]
    (MSTART, MEND) = FACIAL_LANDMARKS_68_IDXS["mouth_1"]
    EYE_AVERAGE = 0
    MOUTH_AVERAGE = 0
    COUNTER = 0
    COUNTER_THRESH = 100
    EYE_STATE = True
    MOUTH_STATE = True
    DEVIATION_1 = 0.8
    DEVIATION_2 = 3
    TIREDNESS_COUNT = 0
    TEMP_COUNTER = 0
    TIREDNESS_DRIVE = False

    def aliyun_params():
        return TIREDNESS_COUNT
    def eye_aspect_ratio(eye):
        # 计算眼睛的长宽比
        A = dist.euclidean(eye[1], eye[5])
        B = dist.euclidean(eye[2], eye[4])
        C = dist.euclidean(eye[0], eye[3])
        ear = (A + B) / (2.0 * C)
        return ear


    def mouth_aspect_ratio(mouth):
        # 计算嘴巴的长宽比
        A = dist.euclidean(mouth[0], mouth[6])
        B = dist.euclidean(mouth[1], mouth[11])
        C = dist.euclidean(mouth[2], mouth[10])
        D = dist.euclidean(mouth[3], mouth[9])
        E = dist.euclidean(mouth[4], mouth[8])
        F = dist.euclidean(mouth[5], mouth[7])
        ear = (B + C + D + E + F) / (5 * A)
        return ear


    def shape_to_np(shape, dtype="int"):
        # 创建68*2
        coords = np.zeros((shape.num_parts, 2), dtype=dtype)
        # 遍历每一个关键点
        # 得到坐标
        for i in range(0, shape.num_parts):
            coords[i] = (shape.part(i).x, shape.part(i).y)
        return coords


    def visualize_eyes_landmarks(image, shape, colors=None, alpha=0.75):
        overlay = image.copy()
        output = image.copy()
        if colors is None:
            colors = [
                (19, 199, 109),
                (19, 199, 109),
                (79, 76, 240),
                (230, 159, 23),
                (168, 100, 168),
                (158, 163, 32),
                (163, 38, 32),
                (180, 42, 220),
            ]
        for (i, name) in enumerate(FACIAL_LANDMARKS_68_IDXS.keys()):
            if name == "right_eye" or name == "left_eye" or name == "mouth_1":
                (j, k) = FACIAL_LANDMARKS_68_IDXS[name]
                pts = shape[j:k]
                for (x, y) in pts:
                    cv2.circle(overlay, (x, y), 1, colors[i], -1)
        cv2.addWeighted(overlay, alpha, output, 1 - alpha, 0, output)
        return output


    # 配置参数
    ap = argparse.ArgumentParser()
    ap.add_argument("-i", "--image", required=True, help="Path to the image")
    ap.add_argument(
        "-p", "--shape-predictor", required=True, help="Path to the shape predictor"
    )
    args = vars(ap.parse_args())
    # 解释器
    detector = dlib.get_frontal_face_detector()
    predictor = dlib.shape_predictor(args["shape_predictor"])
    vc = cv2.VideoCapture(0)
    if vc.isOpened():
        open, frame = vc.read()
    else:
        open = False
    output = None
    while open:
        ret, image = vc.read()
        h, w = image.shape[:2]
        width = 500
        r = width / float(w)
        image = cv2.resize(image, (width, int(r * h)), interpolation=cv2.INTER_AREA)
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        rects = detector(gray, 1)

        try:
            rect = rects[0]
            shape = predictor(gray, rect)
            shape = shape_to_np(shape)
            output = visualize_eyes_landmarks(image, shape, alpha=0.9)
            left_eye = shape[LSTART:LEND]
            right_eye = shape[RSTART:REND]
            mouth = shape[MSTART:MEND]
            left_ear = eye_aspect_ratio(left_eye)
            right_ear = eye_aspect_ratio(right_eye)
            mouth_ear = mouth_aspect_ratio(mouth)
            ear = (left_ear + right_ear) / 2.0
            if EYE_AVERAGE == 0:
                EYE_AVERAGE = ear
                COUNTER += 1
            elif COUNTER <= COUNTER_THRESH:
                EYE_AVERAGE = EYE_AVERAGE * COUNTER / (COUNTER + 1) + ear / (COUNTER + 1)
                MOUTH_AVERAGE = MOUTH_AVERAGE * COUNTER / (COUNTER + 1) + ear / (COUNTER + 1)
                COUNTER += 1
                # print(EYE_AVERAGE)
            else:
                if ear / EYE_AVERAGE > DEVIATION_1:
                    EYE_AVERAGE = EYE_AVERAGE * COUNTER / (COUNTER + 1) + ear / (COUNTER + 1)
                    COUNTER += 1
                if mouth_ear / MOUTH_AVERAGE < DEVIATION_2:
                    MOUTH_AVERAGE = MOUTH_AVERAGE * COUNTER / (COUNTER + 1) + ear / (COUNTER + 1)
                # print(ear / EYE_AVERAGE)
                # print(mouth_ear / MOUTH_AVERAGE)
                if COUNTER >= COUNTER_THRESH and ear / EYE_AVERAGE <= DEVIATION_1 and EYE_STATE is True:
                    EYE_STATE = False
                if COUNTER >= COUNTER_THRESH and mouth_ear / MOUTH_AVERAGE >= DEVIATION_2 and MOUTH_STATE is True:
                    MOUTH_STATE = False
                if ear / EYE_AVERAGE > DEVIATION_1:
                    EYE_STATE = True
                if mouth_ear / MOUTH_AVERAGE < DEVIATION_2:
                    MOUTH_STATE = True
                if EYE_STATE is True and MOUTH_STATE is True and TIREDNESS_COUNT > 0:
                    TIREDNESS_COUNT -= 1
                if MOUTH_STATE is False:
                    TIREDNESS_COUNT += 10
                if EYE_STATE is False:
                    TIREDNESS_COUNT += 5
                if TIREDNESS_COUNT >= 1000:
                    TIREDNESS_DRIVE = True
                if TIREDNESS_COUNT <= 300:
                    TIREDNESS_DRIVE = False
        except:
            pass
        if image is None:
            break
        if ret and output is not None:
            (h, w) = output.shape[:2]
            width = 1000
            r = width / float(w)
            output = cv2.resize(output, (width, int(r * h)), interpolation=cv2.INTER_AREA)
            if COUNTER < COUNTER_THRESH:
                cv2.putText(output, "Collecting Data,Please Wait", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
            else:
                if queue.full():
                    queue.get()
                queue.put(TIREDNESS_COUNT)
                cv2.putText(output, str(EYE_STATE), (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
                cv2.putText(output, str(MOUTH_STATE), (90, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
                cv2.putText(output, "Tiredness: {}".format(TIREDNESS_COUNT / 10), (10, 60), cv2.FONT_HERSHEY_SIMPLEX,
                            0.7, (0, 0, 255), 2)
            if TIREDNESS_DRIVE:
                cv2.putText(output, "TIRED", (10, 90), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
            cv2.imshow("Image", output)
            if cv2.waitKey(20) & 0xFF == 27:
                break
    vc.release()
    cv2.destroyAllWindows()

