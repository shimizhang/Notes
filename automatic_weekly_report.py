import pymsql,openpyxl
import pandas as pd 
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.image import MIMEImage
from email.mime.application import MIMEApplication
from email.mime.base import MIMEBase
from email.header import Header
from email import encoders
from PIL import ImageGrab        #用于获取复制的图片
import win32com.client as win32  #打开excel文件
import smtplib
import time
import datetime


now = datetime.datetime.now()
date=datetime.datetime.strftime(now-datetime.timedelta(days=1), '%Y%m%d') #获取日期
#第一步要做的是建立数据库连接和取数。h
#host是要连接的MySQL服务器地址，port是服务器端口号，user和passwd是用户名和密码，db则是数据库名称。
#charset是连接编码，一般用utf8。
def connectDatabase(sql): 
    db = pymysql.connect(
        host = 'xxxxxx',
        port = xxx,
        user = 'xxxxxxx',
        passwd = 'xxxxxxx',
        db = 'xxxxxxxxx',
        charset = "utf8")     #连接mysql数据库
    conn=db.cursor()          #创建并返回游标
    conn.execute(sql)         #执行数据库的查询命令
    results = conn.fetchall() #获取结果
    conn.close()
    db.close()
    return results

def get_data(sql): #获取数据
    results = connectDatabase(sql)
    return results

sql=''' 
select * from table
 '''   

#第二步就是将取到的数据写到你提前调好格式的excel模板里。
#openpyxl能够读写Excel 2010文档。
#workbook是你打开或创建的文件，可以通过表名定位到每一个sheet，通过坐标获取到每个单元格。
def to_excel(sql_1,sql_2,sql_3,sql_4):
    data1=get_data(sql_1)
    data2=get_data(sql_2)
    data3=get_data(sql_3)
    data4=get_data(sql_4)
workbook=openpyxl.load_workbook('C:\\Users\\Admin\\Desktop\\日报.xlsx') #打开文件
ws1=workbook["Sheet1"] #获取worksheet
ws2=workbook["Sheet2"]
ws3=workbook['all']

for i in range(len(data1)):
    for j in range(len(data1[0])):
        ws1.cell(i+2,j+1,data1[i][j])
for i in range(len(data2)):
    for j in range(len(data2[0])):
        ws2.cell(i+2,j+1,data2[i][j])
for i in range(5):
    for j in range(6):
        if i<4:
            ws3.cell(i+29,j+2,data3[i][j])
        elif j in (1,2):
            ws3.cell(i+29,j+2,(data3[i-1][j]-data3[i-2][j])/data3[i-2][j])
        elif j>2:
            ws3.cell(i+29,j+2,(data3[i-1][j]-data3[i-2][j]))
    for j in range(5):
        if i<4:
            ws3.cell(i+60,j+2,data4[i][j])
        elif i==4 and j>0:
            ws3.cell(i+60,j+2,(data4[i-1][j]-data4[i-2][j])/data4[i-2][j])
workbook.save(filename='C:\\Users\\Admin\\Desktop\\日报.xlsx') #保存文件

#邮件正文：将Excel中的核心数据截图。
#用为win32com.client,可以直接调用VBA的库和截图。
excel = win32.Dispatch('Excel.Application') #获取Excel
wb = excel.Workbooks.Open('C:\\Users\\Admin\\Desktop\\日报.xlsx') #打开excel文件
ws = wb.Worksheets('all')        #获取Sheet
ws.Range('A1:I20').CopyPicture()    #复制A1:I20图片区域
ws.Paste(ws.Range('T1'))            #将图片移动到T1
new_shape_name = 'push'
excel.Selection.ShapeRange.Name = new_shape_name    #选择区域重命名
ws.Shapes(new_shape_name).Copy()    #复制移动的图片Picture 1
img = ImageGrab.grabclipboard()  #获取图片数据
img.save('C:\\Users\\Admin\\Desktop\\p1.png') #图片另存为
wb.SaveAs('C:\\Users\\Admin\\Desktop\\copy'+str(date)+'.xlsx') #excel文件另存为copy.xlsx
wb.Close()

#第三步：编写邮件内容并发送。smtpserver是自己登录账号的目标服务器。
#MIMEMultipart代表的是一个邮件对象，分为文本邮件对象MIMEText和作为附件的图片对象MIMEImage。
#我们用MIMEMultipart的attach函数将数据图片以html的形式插入到邮件正文中。
def sent_mail():
    smtpserver = 'smtp.xxxx.com'
    user='zhangshimin@xxx.com'
    pwd='xxxxxxx'
    receivers=['xxxx1@xxx.com','xxxx2@xxx.com'] #收件人
    msg=MIMEMultipart() 
    title='日报_'+date
    msg.attach(MIMEText('<p><img src="cid:1"></p>', 'html', 'utf-8'))
    fp1 = open('C:\\Users\\Admin\\Desktop\\p1.png', 'rb')
    msgImage1 = MIMEImage(fp1.read())
    fp1.close()
    msgImage1.add_header('Content-ID', '<1>')
    msg.attach(msgImage1)
    #添加附件
    att=MIMEApplication(open('C:\\Users\\Admin\\Desktop\\日报.xlsx','rb').read())
    att.add_header('Content-Disposition', 'attachment', filename=Header('日报'+date+'.xlsx','utf-8').encode())
    msg.attach(att)
    #添加收件发件人信息
    msg['From'] = "{}".format(user)
    msg['To'] = ",".join(receivers)
    msg['Subject'] = title
    #发送邮件
    smtp = smtplib.SMTP()
    smtp.connect(smtpserver)
    #smtp.starttls()
    smtp.login(user,pwd)
    smtp.sendmail(user, receivers, msg.as_string())
    print('发送成功')
    smtp.close()
    time.sleep(10)
to_excel(sql_1,sql_2,sql_3,sql_4) 
sent_mail()