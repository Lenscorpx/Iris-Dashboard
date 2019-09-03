using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Iris.FormsLibrary
{
    public partial class frm_splash : Form
    {
        //Timer timer2 = new Timer();
        public frm_splash()
        {
            InitializeComponent();
            initAll();
        }
        private void initAll()
        {
            timer1.Start();
            timer1.Enabled = true;
            //bunifuProgressBar1.Value = 0;
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (bunifuProgressBar1.Value < 100)
            {
                bunifuProgressBar1.Value += 2;
                bunifuProgressBar1.Refresh();
            }
            else
            {
                timer1.Enabled = false;
                timer1.Stop();
                bunifuProgressBar1.Dispose();
                this.Hide();
                var fr = new frm_main();
                fr.Show();
            }
            
        }
    }
}
