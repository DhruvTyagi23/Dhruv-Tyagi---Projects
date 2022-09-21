classdef SEIRD_LQ < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        UIAxesCalculated              matlab.ui.control.UIAxes
        SEIRDLQModelofContagiousVirusesLabel  matlab.ui.control.Label
        CountryDropDown               matlab.ui.control.DropDown
        VirusDropDown                 matlab.ui.control.DropDown
        UpdateButton                  matlab.ui.control.Button
        DefaultButton                 matlab.ui.control.Button
        AyanAhmad2K19EP027DhruvTyagi2K19EP032Label  matlab.ui.control.Label
        Image                         matlab.ui.control.Image
        DepartmentofAppliedPhysicsDelhiTechnologicalUniversityLabel  matlab.ui.control.Label
        SocialDSwitch                 matlab.ui.control.Switch
        SocialDistancingLabel         matlab.ui.control.Label
        SocialDSlider                 matlab.ui.control.Slider
        SocialDLamp                   matlab.ui.control.Lamp
        QuarantineSwitch              matlab.ui.control.Switch
        QuarantineLabel               matlab.ui.control.Label
        QuarantineSlider              matlab.ui.control.Slider
        QuarantineLamp                matlab.ui.control.Lamp
        LockdownSwitch                matlab.ui.control.Switch
        LockdownLabel_5               matlab.ui.control.Label
        LockdownSlider                matlab.ui.control.Slider
        LockdownLamp                  matlab.ui.control.Lamp
        FatalityRateLabel             matlab.ui.control.Label
        FatalitySlider                matlab.ui.control.Slider
        DurationofInfectionLabel      matlab.ui.control.Label
        DinfSlider                    matlab.ui.control.Slider
        DurationofIncubationLabel     matlab.ui.control.Label
        DincSlider                    matlab.ui.control.Slider
        VirusDropDownLabel_2          matlab.ui.control.Label
        CountryDropDown_2Label_2      matlab.ui.control.Label
        BasicReproductionNumberLabel  matlab.ui.control.Label
        BRNSlider                     matlab.ui.control.Slider
        DincSwitch                    matlab.ui.control.Switch
        DinfSwitch                    matlab.ui.control.Switch
        FatalitySwitch                matlab.ui.control.Switch
        BRNSwitch                     matlab.ui.control.Switch
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function: BRNSlider, BRNSwitch, CountryDropDown, 
        % DincSlider, DincSwitch, DinfSlider, DinfSwitch, 
        % FatalitySlider, FatalitySwitch, LockdownSlider, 
        % LockdownSwitch, QuarantineSlider, QuarantineSwitch, 
        % SocialDSlider, SocialDSwitch, UpdateButton, VirusDropDown
        function UpdateButtonPushed(app, event)

        %% GLOBAL VARIABLES
        
        global N;
        global R_0;
        global death;
        global T_inc;
        global T_inf;
        
        global hosp;
                    
        global beta;
        global gamma;
        global sigma;
        
            
        %% PARAMETERS W.R.T DROP DOWN MENU SELECTIONS (LIBRARY SECTION)
        % The parameters (or constants) of the equations to be used will have different values for a given region and virus.
        
        switch char(app.CountryDropDown.Value)
            case char('India')
                N=1.353e9;
                hosp=(N/1000)*0.53;
                switch char(app.VirusDropDown.Value)
                    case char('SARS COVID-2 (2020)')
                        R_0=2.9;
                        death=1-0.9851;
                        T_inc=4.2;
                        T_inf=14;
                    case char('Ebola (2014)')
                        R_0=1.8;
                        death=1-0.35;
                        T_inc=9;
                        T_inf=20;
                end
                
            case char('Russia')
                N=144.5e6;
                hosp=(N/1000)*8.05;
                switch char(app.VirusDropDown.Value)
                    case char('SARS COVID-2 (2020)')
                        R_0=2.2;
                        death=1-0.9828;
                        T_inc=4.2;
                        T_inf=14;
                    case char('Ebola (2014)')
                        R_0=1.8;
                        death=1-0.35;
                        T_inc=9;
                        T_inf=20;
                end
                
            case char('United Arab Emirates')
                N=9.631e6;
                hosp=(N/1000)*1.4;
                switch char(app.VirusDropDown.Value)
                    case char('SARS COVID-2 (2020)')
                        R_0=2.8;
                        death=1-0.9963;
                        T_inc=4.2;
                        T_inf=14;
                    case char('Ebola (2014)')
                        R_0=1.8;
                        death=1-0.35;
                        T_inc=9;
                        T_inf=20;
                end
                
            case char('United States of America')
                N=328.2e6;
                hosp=(N/1000)*2.77;
                switch char(app.VirusDropDown.Value)
                    case char('SARS COVID-2 (2020)')
                        R_0=2.2;
                        death=1-0.96;
                        T_inc=4.2;
                        T_inf=14;
                    case char('Ebola (2014)')
                        R_0=1.8;
                        death=1-0.35;
                        T_inc=9;
                        T_inf=20;
                end
                
        end
                
                    
        %% FUNCTIONALITY OF SWITCHES    
        % If the switch is off for a particular quantity, its value will be 0, else its value will take the default value assigned above.
       
        if isequal(app.BRNSwitch.Value,'On')
            R_0=app.BRNSlider.Value;
        else
            app.BRNSlider.Value=R_0;
        end
        if isequal(app.DincSwitch.Value,'On')
            T_inc=app.DincSlider.Value;
        else
            app.DincSlider.Value=T_inc;
        end
        if isequal(app.DinfSwitch.Value,'On')
            T_inf=app.DinfSlider.Value;
        else
            app.DinfSlider.Value=T_inf;
        end
        if isequal(app.FatalitySwitch.Value,'On')
            death=app.FatalitySlider.Value;
        else
            app.FatalitySlider.Value=death;
        end
        
        
        if isequal(app.LockdownSwitch.Value,'Off')
            app.LockdownSlider.Value=0;
            app.LockdownLamp.Color=[0.90,0.90,0.90];
        else
            app.LockdownLamp.Color=[0,1,0];
        end
        if isequal(app.SocialDSwitch.Value,'Off')
            app.SocialDSlider.Value=0;
            app.SocialDLamp.Color=[0.90,0.90,0.90];
        else
            app.SocialDLamp.Color=[0,1,0];
        end
        if isequal(app.QuarantineSwitch.Value,'Off')
            app.QuarantineSlider.Value=0;
            app.QuarantineLamp.Color=[0.90,0.90,0.90];
        else
            app.QuarantineLamp.Color=[0,1,0];
        end
        
        
        %% FORMULAS
        
        % BASIC
        beta=R_0/(N*T_inc);
        gamma = 1/T_inf;
        sigma = 1/T_inc;
        
        % ODE 
        t = 0:1:365;
        y0 = [N-28, 0, 25, 3, 0];
        [t,y]=ode45(@(t,y) ode_solve(t,y), t, y0);             
        
        
        %% PLOTTING
        
        plot(app.UIAxesCalculated,t,y,t,100*hosp,'o','LineWidth', 2)
        legend(app.UIAxesCalculated,'Susceptible','Exposed','Infectious','Recovered','Death','100*Capacity','Location','Best')
        
        
        %% ODE SOLVER FUNCTION
        
        function dydt = ode_solve(t,y)
            
        S = y(1);
        E= y(2);
        I = y(3);
        
        dS = -(beta).*(1-app.QuarantineSlider.Value/3).*(1-app.SocialDSlider.Value/5).*I.*S - (app.LockdownSlider.Value/200).*S;
        dL = (app.LockdownSlider.Value/200).*S;
        dE = (beta).*(1-app.QuarantineSlider.Value/3).*(1-app.SocialDSlider.Value/5).*I.*S - sigma.*E;
        dQ = (app.QuarantineSlider.Value/3).*I - (1-app.QuarantineSlider.Value/3).*gamma*(1-death)*I - (app.QuarantineSlider.Value/3).*(death)*gamma*I;
        dI = sigma*E - (1-app.QuarantineSlider.Value/3).*gamma.*I - (app.QuarantineSlider.Value/3).*gamma.*I;
        dR = gamma*(1-death)*I;
        dD = gamma*(death)*I;
        
        dydt = [dS; dE; dI; dR; dD];
        end
        end

        % Button pushed function: DefaultButton
        function DefaultButtonPushed(app, event)
            
            %% DEFAULT SETTING
            % Puts all the switches in 'off' configuration and that triggers the update button which causes all the sliders to take default value as in library section.
            
            app.BRNSwitch.Value='Off';
            app.DincSwitch.Value='Off';
            app.DinfSwitch.Value='Off';
            app.FatalitySwitch.Value='Off';
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1363 869];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxesCalculated
            app.UIAxesCalculated = uiaxes(app.UIFigure);
            title(app.UIAxesCalculated, '')
            xlabel(app.UIAxesCalculated, 'Time Axis (Days)')
            ylabel(app.UIAxesCalculated, 'SEIRD')
            app.UIAxesCalculated.PlotBoxAspectRatio = [1.66614420062696 1 1];
            app.UIAxesCalculated.MinorGridLineStyle = '-';
            app.UIAxesCalculated.XGrid = 'on';
            app.UIAxesCalculated.XMinorGrid = 'on';
            app.UIAxesCalculated.YGrid = 'on';
            app.UIAxesCalculated.YMinorGrid = 'on';
            app.UIAxesCalculated.Position = [13 9 941 577];

            % Create SEIRDLQModelofContagiousVirusesLabel
            app.SEIRDLQModelofContagiousVirusesLabel = uilabel(app.UIFigure);
            app.SEIRDLQModelofContagiousVirusesLabel.FontName = 'Arial Nova Light';
            app.SEIRDLQModelofContagiousVirusesLabel.FontSize = 30;
            app.SEIRDLQModelofContagiousVirusesLabel.FontWeight = 'bold';
            app.SEIRDLQModelofContagiousVirusesLabel.Position = [531 776 511 59];
            app.SEIRDLQModelofContagiousVirusesLabel.Text = 'SEIRD-LQ Model of Contagious Viruses';

            % Create CountryDropDown
            app.CountryDropDown = uidropdown(app.UIFigure);
            app.CountryDropDown.Items = {'India', 'Russia', 'United Arab Emirates', 'United States of America'};
            app.CountryDropDown.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.CountryDropDown.FontSize = 16;
            app.CountryDropDown.Position = [507 597 251 22];
            app.CountryDropDown.Value = 'India';

            % Create VirusDropDown
            app.VirusDropDown = uidropdown(app.UIFigure);
            app.VirusDropDown.Items = {'SARS COVID-2 (2020)', 'Ebola (2014)'};
            app.VirusDropDown.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.VirusDropDown.FontSize = 16;
            app.VirusDropDown.Position = [239 597 251 22];
            app.VirusDropDown.Value = 'SARS COVID-2 (2020)';

            % Create UpdateButton
            app.UpdateButton = uibutton(app.UIFigure, 'push');
            app.UpdateButton.ButtonPushedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.UpdateButton.Position = [818 597 100 22];
            app.UpdateButton.Text = 'Update';

            % Create DefaultButton
            app.DefaultButton = uibutton(app.UIFigure, 'push');
            app.DefaultButton.ButtonPushedFcn = createCallbackFcn(app, @DefaultButtonPushed, true);
            app.DefaultButton.Position = [82 597 100 22];
            app.DefaultButton.Text = 'Default';

            % Create AyanAhmad2K19EP027DhruvTyagi2K19EP032Label
            app.AyanAhmad2K19EP027DhruvTyagi2K19EP032Label = uilabel(app.UIFigure);
            app.AyanAhmad2K19EP027DhruvTyagi2K19EP032Label.FontSize = 16;
            app.AyanAhmad2K19EP027DhruvTyagi2K19EP032Label.Position = [576 707 422 24];
            app.AyanAhmad2K19EP027DhruvTyagi2K19EP032Label.Text = 'Ayan Ahmad (2K19/EP/027) & Dhruv Tyagi (2K19/EP/032)';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [360 692 144 143];
            app.Image.ImageSource = 'DTU.png';

            % Create DepartmentofAppliedPhysicsDelhiTechnologicalUniversityLabel
            app.DepartmentofAppliedPhysicsDelhiTechnologicalUniversityLabel = uilabel(app.UIFigure);
            app.DepartmentofAppliedPhysicsDelhiTechnologicalUniversityLabel.FontSize = 18;
            app.DepartmentofAppliedPhysicsDelhiTechnologicalUniversityLabel.Position = [536 747 503 30];
            app.DepartmentofAppliedPhysicsDelhiTechnologicalUniversityLabel.Text = 'Department of Applied Physics, Delhi Technological University';

            % Create SocialDSwitch
            app.SocialDSwitch = uiswitch(app.UIFigure, 'slider');
            app.SocialDSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.SocialDSwitch.Position = [1261 78 45 20];

            % Create SocialDistancingLabel
            app.SocialDistancingLabel = uilabel(app.UIFigure);
            app.SocialDistancingLabel.FontSize = 16;
            app.SocialDistancingLabel.Position = [999 77 129 22];
            app.SocialDistancingLabel.Text = 'Social Distancing';

            % Create SocialDSlider
            app.SocialDSlider = uislider(app.UIFigure);
            app.SocialDSlider.Limits = [0 0.9];
            app.SocialDSlider.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.SocialDSlider.Position = [999 59 326 3];

            % Create SocialDLamp
            app.SocialDLamp = uilamp(app.UIFigure);
            app.SocialDLamp.Position = [969 50 20 20];
            app.SocialDLamp.Color = [0.902 0.902 0.902];

            % Create QuarantineSwitch
            app.QuarantineSwitch = uiswitch(app.UIFigure, 'slider');
            app.QuarantineSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.QuarantineSwitch.Position = [1261 170 45 20];

            % Create QuarantineLabel
            app.QuarantineLabel = uilabel(app.UIFigure);
            app.QuarantineLabel.FontSize = 16;
            app.QuarantineLabel.Position = [999 169 84 22];
            app.QuarantineLabel.Text = 'Quarantine';

            % Create QuarantineSlider
            app.QuarantineSlider = uislider(app.UIFigure);
            app.QuarantineSlider.Limits = [0 0.9];
            app.QuarantineSlider.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.QuarantineSlider.Position = [999 151 326 3];

            % Create QuarantineLamp
            app.QuarantineLamp = uilamp(app.UIFigure);
            app.QuarantineLamp.Position = [969 142 20 20];
            app.QuarantineLamp.Color = [0.902 0.902 0.902];

            % Create LockdownSwitch
            app.LockdownSwitch = uiswitch(app.UIFigure, 'slider');
            app.LockdownSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.LockdownSwitch.Position = [1261 261 45 20];

            % Create LockdownLabel_5
            app.LockdownLabel_5 = uilabel(app.UIFigure);
            app.LockdownLabel_5.FontSize = 16;
            app.LockdownLabel_5.Position = [999 260 78 22];
            app.LockdownLabel_5.Text = 'Lockdown';

            % Create LockdownSlider
            app.LockdownSlider = uislider(app.UIFigure);
            app.LockdownSlider.Limits = [0 0.9];
            app.LockdownSlider.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.LockdownSlider.Position = [999 242 326 3];

            % Create LockdownLamp
            app.LockdownLamp = uilamp(app.UIFigure);
            app.LockdownLamp.Position = [969 233 20 20];
            app.LockdownLamp.Color = [0.902 0.902 0.902];

            % Create FatalityRateLabel
            app.FatalityRateLabel = uilabel(app.UIFigure);
            app.FatalityRateLabel.FontSize = 16;
            app.FatalityRateLabel.Position = [999 352 95 22];
            app.FatalityRateLabel.Text = 'Fatality Rate';

            % Create FatalitySlider
            app.FatalitySlider = uislider(app.UIFigure);
            app.FatalitySlider.Limits = [0 1];
            app.FatalitySlider.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.FatalitySlider.Position = [999 334 326 3];

            % Create DurationofInfectionLabel
            app.DurationofInfectionLabel = uilabel(app.UIFigure);
            app.DurationofInfectionLabel.FontSize = 16;
            app.DurationofInfectionLabel.Position = [999 444 149 22];
            app.DurationofInfectionLabel.Text = 'Duration of Infection';

            % Create DinfSlider
            app.DinfSlider = uislider(app.UIFigure);
            app.DinfSlider.Limits = [0 30];
            app.DinfSlider.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.DinfSlider.Position = [999 426 326 3];

            % Create DurationofIncubationLabel
            app.DurationofIncubationLabel = uilabel(app.UIFigure);
            app.DurationofIncubationLabel.FontSize = 16;
            app.DurationofIncubationLabel.Position = [999 535 162 22];
            app.DurationofIncubationLabel.Text = 'Duration of Incubation';

            % Create DincSlider
            app.DincSlider = uislider(app.UIFigure);
            app.DincSlider.Limits = [0 30];
            app.DincSlider.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.DincSlider.Position = [999 517 326 3];

            % Create VirusDropDownLabel_2
            app.VirusDropDownLabel_2 = uilabel(app.UIFigure);
            app.VirusDropDownLabel_2.HorizontalAlignment = 'right';
            app.VirusDropDownLabel_2.FontSize = 16;
            app.VirusDropDownLabel_2.Position = [345 635 40 22];
            app.VirusDropDownLabel_2.Text = 'Virus';

            % Create CountryDropDown_2Label_2
            app.CountryDropDown_2Label_2 = uilabel(app.UIFigure);
            app.CountryDropDown_2Label_2.HorizontalAlignment = 'right';
            app.CountryDropDown_2Label_2.FontSize = 16;
            app.CountryDropDown_2Label_2.Position = [604 635 58 22];
            app.CountryDropDown_2Label_2.Text = 'Country';

            % Create BasicReproductionNumberLabel
            app.BasicReproductionNumberLabel = uilabel(app.UIFigure);
            app.BasicReproductionNumberLabel.FontSize = 16;
            app.BasicReproductionNumberLabel.Position = [999 625 207 22];
            app.BasicReproductionNumberLabel.Text = 'Basic Reproduction Number';

            % Create BRNSlider
            app.BRNSlider = uislider(app.UIFigure);
            app.BRNSlider.Limits = [0 5];
            app.BRNSlider.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.BRNSlider.Position = [999 607 326 3];

            % Create DincSwitch
            app.DincSwitch = uiswitch(app.UIFigure, 'slider');
            app.DincSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.DincSwitch.Position = [1261 536 45 20];

            % Create DinfSwitch
            app.DinfSwitch = uiswitch(app.UIFigure, 'slider');
            app.DinfSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.DinfSwitch.Position = [1261 445 45 20];

            % Create FatalitySwitch
            app.FatalitySwitch = uiswitch(app.UIFigure, 'slider');
            app.FatalitySwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.FatalitySwitch.Position = [1262 353 45 20];

            % Create BRNSwitch
            app.BRNSwitch = uiswitch(app.UIFigure, 'slider');
            app.BRNSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.BRNSwitch.Position = [1263 626 45 20];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SEIRD_LQ

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end