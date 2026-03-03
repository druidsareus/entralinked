package entralinked.gui.panels;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.formdev.flatlaf.extras.components.FlatTextField;

import entralinked.Configuration;
import entralinked.Entralinked;
import entralinked.utility.SwingUtility;
import net.miginfocom.swing.MigLayout;

@SuppressWarnings("serial")
public class SettingsPanel extends JPanel {
    
    private final Entralinked entralinked;
    private final JTextField dnsAddressField;
    private final JLabel dnsStatusLabel;
    private final JButton saveButton;
    private final JButton resetButton;
    
    public SettingsPanel(Entralinked entralinked) {
        this.entralinked = entralinked;
        setLayout(new BorderLayout());
        
        // Create settings container
        JPanel settingsContainer = new JPanel(new MigLayout("wrap, gapy 16, insets 16"));
        
        // Create DNS configuration section
        JPanel dnsPanel = createDnsConfigPanel();
        settingsContainer.add(dnsPanel, "growx");
        
        // Create button panel
        JPanel buttonPanel = new JPanel(new GridLayout(1, 2, 8, 0));
        
        saveButton = new JButton("Save Settings");
        saveButton.addActionListener(event -> saveSettings());
        buttonPanel.add(saveButton);
        
        resetButton = new JButton("Reset to Default");
        resetButton.addActionListener(event -> resetToDefault());
        buttonPanel.add(resetButton);
        
        // Create footer
        JPanel footerPanel = new JPanel(new BorderLayout());
        footerPanel.add(buttonPanel, BorderLayout.LINE_END);
        footerPanel.setBorder(BorderFactory.createEmptyBorder(8, 16, 16, 16));
        
        // Add components to main panel
        add(settingsContainer, BorderLayout.CENTER);
        add(footerPanel, BorderLayout.PAGE_END);
        
        // Initialize field values
        updateFieldsFromConfig();
    }
    
    private JPanel createDnsConfigPanel() {
        JPanel panel = new JPanel(new MigLayout("wrap, gapy 8, insets 12"));
        panel.setBorder(BorderFactory.createTitledBorder("DNS Configuration"));
        
        // Title
        JLabel titleLabel = SwingUtility.createTitleLabel("DNS Server Address");
        panel.add(titleLabel, "growx");
        
        // Description
        JLabel descriptionLabel = SwingUtility.createDescriptionLabel(
            "<html>Specify the DNS address for the DS to connect to.<br/>" +
            "Leave empty to auto-detect the local host address.<br/>" +
            "Supports both IPv4 addresses and hostnames (e.g., game-server.local).</html>"
        );
        panel.add(descriptionLabel, "growx, gapy 0 8");
        
        // DNS Address input
        panel.add(new JLabel("DNS Address:"), "");
        dnsAddressField = new FlatTextField();
        dnsAddressField.setPlaceholderText("e.g., 192.168.1.100 or game-server.local");
        panel.add(dnsAddressField, "growx");
        
        // Status label
        dnsStatusLabel = new JLabel(" ");
        dnsStatusLabel.setForeground(java.awt.Color.GRAY);
        dnsStatusLabel.setFont(dnsStatusLabel.getFont().deriveFont(java.awt.Font.PLAIN, 11));
        panel.add(dnsStatusLabel, "growx, gapy 4 0");
        
        // Test button
        JButton testButton = new JButton("Test Address");
        testButton.addActionListener(event -> testDnsAddress());
        panel.add(testButton, "growx, gapy 8 0");
        
        return panel;
    }
    
    private void testDnsAddress() {
        String address = dnsAddressField.getText().trim();
        
        if(address.isEmpty()) {
            dnsStatusLabel.setText("No custom DNS set - will use auto-detection");
            dnsStatusLabel.setForeground(java.awt.Color.GRAY);
            return;
        }
        
        try {
            InetAddress resolved = InetAddress.getByName(address);
            dnsStatusLabel.setText("✓ Valid - Resolves to: " + resolved.getHostAddress());
            dnsStatusLabel.setForeground(new java.awt.Color(0, 128, 0)); // Green
        } catch(UnknownHostException e) {
            dnsStatusLabel.setText("✗ Invalid - Cannot resolve hostname");
            dnsStatusLabel.setForeground(new java.awt.Color(255, 0, 0)); // Red
        }
    }
    
    private void updateFieldsFromConfig() {
        Configuration config = entralinked.getConfiguration();
        String dnsAddress = config.dnsAddress();
        dnsAddressField.setText(dnsAddress != null ? dnsAddress : "");
        
        // Update status
        if(dnsAddress == null || dnsAddress.isEmpty()) {
            dnsStatusLabel.setText("No custom DNS set - will use auto-detection");
            dnsStatusLabel.setForeground(java.awt.Color.GRAY);
        } else {
            testDnsAddress();
        }
    }
    
    private void saveSettings() {
        String newDnsAddress = dnsAddressField.getText().trim();
        
        // Validate if not empty
        if(!newDnsAddress.isEmpty()) {
            try {
                InetAddress.getByName(newDnsAddress);
            } catch(UnknownHostException e) {
                JOptionPane.showMessageDialog(this,
                    "Invalid DNS address. Cannot resolve: " + newDnsAddress,
                    "Validation Error",
                    JOptionPane.WARNING_MESSAGE);
                return;
            }
        }
        
        // Save to config.json
        Configuration currentConfig = entralinked.getConfiguration();
        Configuration newConfig = new Configuration(
            currentConfig.hostName(),
            newDnsAddress.isEmpty() ? null : newDnsAddress,
            currentConfig.clearPlayerDreamInfoOnWake(),
            currentConfig.allowOverwritingPlayerDreamInfo(),
            currentConfig.allowPlayerGameVersionMismatch(),
            currentConfig.allowWfcRegistrationThroughLogin()
        );
        
        try {
            ObjectMapper mapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
            mapper.writeValue(new File("config.json"), newConfig);
            
            dnsStatusLabel.setText("✓ Settings saved successfully");
            dnsStatusLabel.setForeground(new java.awt.Color(0, 128, 0)); // Green
            
            JOptionPane.showMessageDialog(this,
                "Settings saved successfully!\n\n" +
                "Note: DNS changes will take effect on the next restart.",
                "Success",
                JOptionPane.INFORMATION_MESSAGE);
        } catch(IOException e) {
            dnsStatusLabel.setText("✗ Failed to save settings");
            dnsStatusLabel.setForeground(new java.awt.Color(255, 0, 0)); // Red
            
            SwingUtility.showExceptionInfo(this, "Failed to save settings.", e);
        }
    }
    
    private void resetToDefault() {
        int result = JOptionPane.showConfirmDialog(this,
            "Reset DNS configuration to default (auto-detect)?",
            "Confirm Reset",
            JOptionPane.YES_NO_OPTION,
            JOptionPane.QUESTION_MESSAGE);
        
        if(result != JOptionPane.YES_OPTION) {
            return;
        }
        
        dnsAddressField.setText("");
        
        Configuration currentConfig = entralinked.getConfiguration();
        Configuration newConfig = new Configuration(
            currentConfig.hostName(),
            null,
            currentConfig.clearPlayerDreamInfoOnWake(),
            currentConfig.allowOverwritingPlayerDreamInfo(),
            currentConfig.allowPlayerGameVersionMismatch(),
            currentConfig.allowWfcRegistrationThroughLogin()
        );
        
        try {
            ObjectMapper mapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
            mapper.writeValue(new File("config.json"), newConfig);
            
            dnsStatusLabel.setText("✓ Reset to default (auto-detection)");
            dnsStatusLabel.setForeground(new java.awt.Color(0, 128, 0)); // Green
            
            JOptionPane.showMessageDialog(this,
                "DNS configuration reset to default.\n\n" +
                "Note: Changes will take effect on the next restart.",
                "Reset Complete",
                JOptionPane.INFORMATION_MESSAGE);
        } catch(IOException e) {
            dnsStatusLabel.setText("✗ Failed to reset settings");
            dnsStatusLabel.setForeground(new java.awt.Color(255, 0, 0)); // Red
            
            SwingUtility.showExceptionInfo(this, "Failed to reset settings.", e);
        }
    }
}
