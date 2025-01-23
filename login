from tkinter import Tk
from login import Login_Window

def main():
    win = Tk()
    app = Login_Window(win)
    win.mainloop()

if __name__ == "__main__":
    main()
from tkinter import *
from tkinter import ttk
from PIL import Image, ImageTk
from tkinter import messagebox
import mysql.connector
from register import Register
from hotel import HotelManagementSystem

class Login_Window:
    def __init__(self, root):
        self.root = root
        self.root.title("Login")
        self.root.geometry('1550x800+0+0')

        self.bg = ImageTk.PhotoImage(file=r"Images\loginbg.jpg")
        lbg_bg = Label(self.root, image=self.bg)
        lbg_bg.place(x=0, y=0, relwidth=1, relheight=1)

        frame = Frame(self.root, bg='black')
        frame.place(x=610, y=170, width=340, height=450)

        img1 = Image.open(r"Images\loginicon.jpg")
        img1 = img1.resize((100, 100), Image.ANTIALIAS)
        self.photoimage1 = ImageTk.PhotoImage(img1)
        lblimg1 = Label(image=self.photoimage1, bg='black', borderwidth=0)
        lblimg1.place(x=730, y=175, width=100, height=100)

        get_str = Label(frame, text="Get Started", font=('times new roman', 20, 'bold'), fg='white', bg='black')
        get_str.place(x=95, y=100)

        self.txtuser = ttk.Entry(frame, font=('times new roman', 15, 'bold'))
        self.txtuser.place(x=40, y=180, width=270)

        password = Label(frame, text="Password", font=('times new roman', 12, 'bold'), fg='white', bg='black')
        password.place(x=70, y=225)

        self.txtpass = ttk.Entry(frame, font=('times new roman', 15, 'bold'))
        self.txtpass.place(x=40, y=250, width=270)

        loginbtn = Button(frame, text="Login", command=self.login, font=('times new roman', 15, 'bold'), bg='blue', fg='white', relief=RIDGE, bd=3, activeforeground='white', activebackground='blue')
        loginbtn.place(x=110, y=300, width=120, height=35)

        registerbtn = Button(frame, text="New User Register", command=self.register_window, font=('times new roman', 10, 'bold'), borderwidth=0, bg='black', fg='white', activeforeground='white', activebackground='black')
        registerbtn.place(x=15, y=370, width=160)

        forgotbtn = Button(frame, text="Forgot password", command=self.forgot_password_window, font=('times new roman', 10, 'bold'), borderwidth=0, bg='black', fg='white', activeforeground='white', activebackground='black')
        forgotbtn.place(x=10, y=340, width=160)

    def register_window(self):
        self.new_window = Toplevel(self.root)
        self.app = Register(self.new_window)

    def login(self):
        if self.txtuser.get() == "" or self.txtpass.get() == "":
            messagebox.showerror("Error", "All fields are required")
        elif self.txtuser.get() == "ross" and self.txtpass.get() == "green":
            messagebox.showinfo("Success", "You are successfully logged in")
        else:
            conn = mysql.connector.connect(host="localhost", user='root', password='amma*20*12', database='management')
            my_cursor = conn.cursor()
            my_cursor.execute("select * from register where email=%s and password=%s", (self.txtuser.get(), self.txtpass.get()))
            row = my_cursor.fetchone()
            if row == None:
                messagebox.showerror("Error", "Invalid Username & password")
            else:
                open_main = messagebox.askyesno("YesNo", "Access only admin")
                if open_main > 0:
                    self.new_window = Toplevel(self.root)
                    self.app = HotelManagementSystem(self.new_window)
                else:
                    return
            conn.commit()
            conn.close()

    def forgot_password_window(self):
        if self.txtuser.get() == "":
            messagebox.showerror("Error", "Please Enter the Email address to reset password")
        else:
            conn = mysql.connector.connect(host="localhost", user='root', password='amma*20*12', database='management')
            my_cursor = conn.cursor()
            query = "Select * from register where email=%s"
            value = (self.txtuser.get(),)
            my_cursor.execute(query, value)
            row = my_cursor.fetchone()
            if row == None:
                messagebox.showerror("Error", "Please enter the valid username")
            else:
                conn.close()
                self.root2 = Toplevel()
                self.root2.title("Forgot Password")
                self.root2.geometry("340x450+610+170")
                # UI code for the password reset window goes here
class HotelManagementSystem:
    def __init__(self, root):
        self.root = root
        self.root.title("Hotel Management System")
        self.root.geometry('1550x800+0+0')
        # Your hotel management system implementation here
