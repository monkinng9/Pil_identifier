from flask import Flask, request, jsonify
from detect5 import *

import werkzeug

app = Flask(__name__)

@app.route('/upload', methods=["POST"])
def upload():
    if(request.method == "POST"):
        imagefile = request.files['image']
        
        model_dir = "faster_rcnn_inception_resnet_v2_640x640_coco17_tpu-8\saved_model"
        model = tf.saved_model.load(str(model_dir))
        model = model.signatures['serving_default']
        detection_model = model

        show_inference(detection_model, imagefile)

        print(show_inference.display_name)
        # print(type(show_inference.display_name))

        return jsonify({
            "message": show_inference.display_name
        })

if __name__ == "__main__":
    app.run(debug=True, port=4000)