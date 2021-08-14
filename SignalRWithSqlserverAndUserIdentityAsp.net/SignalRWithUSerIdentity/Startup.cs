using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI;
using Microsoft.OpenApi.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Configuration;

using Microsoft.Extensions.DependencyInjection;
using SignalRWithUSerIdentity.Data;
using SignalRWithUSerIdentity.Hubs;
using SignalRWithUSerIdentity.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace SignalRWithUSerIdentity
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "SignalRWithUSerIdentity", Version = "v1" });
            });
            services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(
                    Configuration.GetConnectionString("DefaultConnection")));
            services.AddDefaultIdentity<AppUser>(options => { options.SignIn.RequireConfirmedAccount = true; })
             .AddRoles<IdentityRole>()
             .AddEntityFrameworkStores<ApplicationDbContext>();
            services.AddDatabaseDeveloperPageExceptionFilter();

            services.AddControllersWithViews();
            // services.AddTransient<IUserRepository, UserRepository>();
          
            services.Configure<IdentityOptions>(op => {

                op.Password.RequireDigit = false;
                op.Password.RequireNonAlphanumeric = false;
                op.Password.RequireUppercase = false;
                op.Password.RequireLowercase = false;
                op.Password.RequiredLength = 4;


            });
            //var key = Encoding.UTF8.GetBytes("1234567890123456");

            //services.AddAuthentication(x =>
            //{
            //    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            //    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            //    x.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
            //}).AddJwtBearer(x => {
            //    x.RequireHttpsMetadata = false;
            //    x.SaveToken = false;
            //    x.TokenValidationParameters = new TokenValidationParameters
            //    {
            //        ValidateIssuerSigningKey = true,
            //        IssuerSigningKey = new SymmetricSecurityKey(key),
            //        ValidateIssuer = false,
            //        ValidateAudience = false,
            //        ClockSkew = TimeSpan.Zero
            //    };
            //});

            services.AddSignalR();
            services.AddMvcCore();
            services.AddCors(options => options.AddPolicy("CorsPolicy",
            builder =>
            {
                builder.AllowAnyHeader()
                       .AllowAnyMethod()
                       .WithOrigins()
                       .SetIsOriginAllowed((host) => true)
                       .AllowCredentials();
            }));
            //var key = Encoding.UTF8.GetBytes("1234567890123456");

            //services.AddAuthentication(x =>
            //{
            //    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            //    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            //    x.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
            //}).AddJwtBearer(x => {
            //    x.RequireHttpsMetadata = false;
            //    x.SaveToken = false;
            //    x.TokenValidationParameters = new TokenValidationParameters
            //    {
            //        ValidateIssuerSigningKey = true,
            //        IssuerSigningKey = new SymmetricSecurityKey(key),
            //        ValidateIssuer = false,
            //        ValidateAudience = false,
            //        ClockSkew = TimeSpan.Zero
            //    };
            //});
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.Use(async (ctx, next) =>
            {
                await next();
                if (ctx.Response.StatusCode == 204)
                {
                    ctx.Response.ContentLength = 0;
                }
            });
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseMigrationsEndPoint();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "SignalRWithUSerIdentity v1"));
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();
   
            //app.UseSignalR(routes =>
            //{
            //    routes.MapHub<cacheHub>("/cacheHub");
            //});

            app.UseAuthentication();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
                endpoints.MapRazorPages();
                endpoints.MapHub<Chat>("/Home/Index");
            });
        }
    }
}
