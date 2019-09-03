using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Iris.UserControlsLibrary;

namespace Iris.FormsLibrary
{
    public partial class frm_main : Form
    {
        public frm_main()
        {
            InitializeComponent();
            
        }

        public void call_test()
        {
            var fr = new uc_login ()
            {
                Size = panel3.Size
            };
            panel3.Controls.Clear();
            panel3.Controls.Add(fr);
            fr.Visible = false;
            bunifuTransition1.AnimationType = BunifuAnimatorNS.AnimationType.HorizSlide;
            bunifuTransition1.ShowSync(fr);
            fr.Visible = true;
        }
        private void frm_main_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Exit();
        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {
            call_test();
        }

        private void pictureBox2_MouseClick(object sender, MouseEventArgs e)
        {
            call_test();
        }
    }
}
