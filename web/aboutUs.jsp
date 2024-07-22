<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Paradisa Center</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background: url('https://cdn.dribbble.com/users/2510653/screenshots/5082046/image.gif') no-repeat center center fixed;
                background-size: cover;
                background-position: center 30%;
                margin: 0;
                padding: 0;
                justify-content: center;
                align-items: center;
                height: 100vh;
                color: white;
            }
            .container {
                text-align: center;
                background-color: rgba(255, 255, 255, 0.9);
                padding: 50px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
                border-radius: 10px;
                max-width: 900px;
            }
            .container h1 {
                font-size: 36px;
                color: #5a5a5a;
                animation: fadeIn 2s ease-in-out;
            }
            .container p {
                font-size: 24px;
                color: #777;
                font-weight: 700;
                animation: fadeIn 2s ease-in-out;
            }
            .service {
                margin: 20px 0;
                text-align: center;
                transition: transform 0.3s;
            }
            .service:hover {
                transform: scale(1.05);
            }
            .service img {
                border-radius: 50%;
                width: 150px;
                height: 150px;
                object-fit: cover;
                transition: box-shadow 0.3s;
            }
            .service img:hover {
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
            }
            .service-title {
                margin-top: 10px;
                font-size: 18px;
                color: #333;
                animation: fadeIn 3s ease-in-out;
            }
            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }
        </style>
    </head>
    <jsp:include page="/shared/_head.jsp" />
    <body>
      
 
        <jsp:include page="/shared/_header.jsp" />

        <jsp:include page="/shared/_nav.jsp" />
         <jsp:include page="/shared/_head.jsp" />
        <div class="container">
            <h1>Welcome to our project</h1>
            <p>Mentor Quach Luyl Da</p>
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-6 service">
                    <img src="https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg" alt="Nguyen Thanh Thien">
                    <div class="service-title">Nguyen Thanh Thien</div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6 service">
                    <img src="https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg" alt="Nguyen Hoang Hue Nhan">
                    <div class="service-title">Nguyen Hoang Hue Nhan (Leader)</div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6 service">
                    <img src="https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg" alt="Vo Cao Tai">
                    <div class="service-title">Vo Cao Tai</div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-6 service">
                    <img src="https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg" alt="Nguyen Thi Bich Tien">
                    <div class="service-title">Nguyen Thi Bich Tien</div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6 service">
                    <img src="https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg" alt="Nguyen Khanh Duy">
                    <div class="service-title">Nguyen Khanh Duy</div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6 service">
                    <img src="https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg" alt="Lai Le Tuan Kiet">
                    <div class="service-title">Lai Le Tuan Kiet</div>
                </div>
            </div>
        </div>
               <jsp:include page="/shared/_footer.jsp" />  

    </body>
</html>
