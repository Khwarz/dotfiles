import io
import uuid
from typing import Any

import numpy as np
import torch
import torchvision
from fastapi import APIRouter, BackgroundTasks, UploadFile
from PIL import Image
from torch import nn
from torchvision import models, transforms

from ..websockets import socket_connections

router = APIRouter(prefix="/users")

CLASSES: list[str] = [
    "akshay-kumar",
    "alexandra-daddario",
    "alia-bhatt",
    "amitabh-bachchan",
    "andy-samberg",
    "anushka-sharma",
    "billie-eilish",
    "brad-pitt",
    "camila-cabello",
    "charlize-theron",
    "claire-holt",
    "courtney-cox",
    "dwayne-johnson",
    "elizabeth-olsen",
    "ellen-degeneres",
    "henry-cavill",
    "hrithik-roshan",
    "hugh-jackman",
    "jessica-alba",
    "kashyap",
    "lisa-kudrow",
    "margot-robbie",
    "marmik",
    "natalie-portman",
    "priyanka-chopra",
    "robert-downey-jr",
    "roger-federer",
    "tom-cruise",
    "vijay-deverakonda",
    "virat-kohli",
    "zac-efron",
    "unknown",
]


def transform_image(image_bytes: bytes) -> torch.Tensor:
    mean = np.array([0.5, 0.5, 0.5])
    std = np.array([0.25, 0.25, 0.25])
    my_transforms = transforms.Compose(
        [
            transforms.Resize(256),
            transforms.CenterCrop(224),
            transforms.ToTensor(),
            transforms.Normalize(mean, std),
        ]
    )
    image = Image.open(io.BytesIO(image_bytes))
    return my_transforms(image).unsqueeze(0)


def get_prediction(image_bytes: bytes, client_id: Any) -> torch.Tensor:
    model = models.resnet18(weights=torchvision.models.ResNet18_Weights.DEFAULT)

    num_ftrs = model.fc.in_features
    model.fc = nn.Linear(num_ftrs, 32)

    model.load_state_dict(
        torch.load(
            "/home/emmanuel/Documents/Code/safe-api/src/model/output/model-resnet18.pth",
        ),
    )
    model.eval()
    tensor = transform_image(image_bytes=image_bytes)
    outputs = model.forward(tensor)
    print(outputs)
    print(outputs.max(1))
    _, y_hat = outputs.max(1)
    socket_connections.send_message(
        {
            "can_login": y_hat.item() > 0.9,
            "class_id": y_hat.item(),
            "class_name": CLASSES[y_hat.item()],
        },
        ws_token=client_id,
    )
    return y_hat


@router.post("/login")
async def face_detection(
    face_img: UploadFile, background_tasks: BackgroundTasks
) -> dict[str, Any]:
    client_id: str = uuid.uuid4().hex
    contents = await face_img.read()
    background_tasks.add_task(get_prediction, contents, client_id)
    return {"message": "Message sent", "task_id": client_id}
